/*
 * Copyright (c) 1997,1998 Maxim Bolotin and Oleg Sharoiko.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice unmodified, this list of conditions, and the following
 *    disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 *
 */

/*
 * $Id: if_cs.c,v 1.7 1998/07/19 16:01:23 root Exp root $
 *
 * Device driver for Crystal Semiconductor CS8920 based ethernet
 *   adapters. By Maxim Bolotin and Oleg Sharoiko, 27-April-1997
 */

/* #define	 CS_DEBUG */
#include "cs.h"
#include "bpfilter.h"

#include <sys/param.h>
#include <sys/systm.h>
#include <sys/malloc.h>
#include <sys/sockio.h>
#include <sys/kernel.h>
#include <sys/mbuf.h>
#include <sys/socket.h>
#include <sys/syslog.h>

#include <net/if.h>
#include <net/if_arp.h>
#include <net/if_dl.h>
#include <net/if_mib.h>
#include <net/if_media.h>
#include <net/if_types.h>
#include <net/ethernet.h>

#ifdef INET
#include <netinet/in.h>
#include <netinet/in_systm.h>
#include <netinet/in_var.h>
#include <netinet/ip.h>
#include <netinet/if_ether.h>
#endif

#ifdef IPX
#include <netipx/ipx.h>
#include <netipx/ipx_if.h>
#endif

#ifdef NS
#include <netns/ns.h>
#include <netns/ns_if.h>
#endif

#if NBPFILTER > 0
#include <net/bpf.h>
#include <net/bpfdesc.h>
#endif

#include <machine/clock.h>
#include <machine/md_var.h>

#include <i386/isa/isa_device.h>
#include <i386/isa/icu.h>
#include <i386/isa/if_csreg.h>

#include "pnp.h"

#if NPNP > 0
#include <i386/isa/pnp.h>
#endif

#ifdef  CS_USE_64K_DMA
#define CS_DMA_BUFFER_SIZE 65536
#else
#define CS_DMA_BUFFER_SIZE 16384
#endif

#ifndef CS_WAIT_NEXT_PACKET
#define	CS_WAIT_NEXT_PACKET 570
#endif

/*
 * cs_softc: per line info and status
 */
static struct cs_softc {

        /* Ethernet common code */
        struct arpcom arpcom;

        /* Configuration words from EEPROM */
        int auto_neg_cnf;               /* AutoNegotitation configuration */
	int adapter_cnf;                /* Adapter configuration */
        int isa_config;                 /* ISA configuration */
        int chip_type;			/* Type of chip */

        struct ifmedia media;		/* Media information */

        int nic_addr; 			/* Base IO address of card */
	int send_cmd;
        int line_ctl;                   /* */
        int send_underrun;
        void *recv_ring;

        unsigned char *buffer;
        int buf_len;

} cs_softc[NCS];

static u_long	cs_unit = NCS;

static int      cs_attach               __P((struct cs_softc *, int, int));
static int      cs_attach_isa           __P((struct isa_device *));
static void	cs_init			__P((void *));
static int	cs_ioctl		__P((struct ifnet *, u_long, caddr_t));
static int	cs_probe		__P((struct isa_device *));
static int	cs_cs89x0_probe		__P((struct cs_softc *,
					 u_int *, int *, int, int, int));
static void	cs_start		__P((struct ifnet *));
static void	cs_stop			__P((struct cs_softc *));
static void	cs_reset		__P((struct cs_softc *));
static void	cs_watchdog		__P((struct ifnet *));

static int	cs_mediachange	__P((struct ifnet *));
static void	cs_mediastatus	__P((struct ifnet *, struct ifmediareq *));
static int      cs_mediaset	__P((struct cs_softc *, int));

static void	cs_write_mbufs(struct cs_softc*, struct mbuf*);
static void	cs_xmit_buf(struct cs_softc*);
static int	cs_get_packet(struct cs_softc*);
static void	cs_setmode(struct cs_softc*);

static int	get_eeprom_data(struct cs_softc *sc, int, int, int *);
static int	get_eeprom_cksum(int, int, int *);
static int	wait_eeprom_ready( struct cs_softc *);
static void	control_dc_dc( struct cs_softc *, int );
static int	send_test_pkt( struct cs_softc * );
static int	enable_tp(struct cs_softc *);
static int	enable_aui(struct cs_softc *);
static int	enable_bnc(struct cs_softc *);
static int      cs_duplex_auto(struct cs_softc *);

struct isa_driver csdriver = {
	cs_probe,
	cs_attach_isa,
	CS_NAME,
	0
};

static int
get_eeprom_data( struct cs_softc *sc, int off, int len, int *buffer)
{
	int i;

#ifdef CS_DEBUG
	printf(CS_NAME":EEPROM data from %x for %x:\n", off,len);
#endif

	for (i=0;i<len;i++) {
		if (wait_eeprom_ready(sc) < 0) return -1;
		/* Send command to EEPROM to read */
		cs_writereg(sc->nic_addr, PP_EECMD, (off+i)|EEPROM_READ_CMD );
		if (wait_eeprom_ready(sc)<0)
			return -1;
		buffer[i] = cs_readreg (sc->nic_addr, PP_EEData);

#ifdef CS_DEBUG
		printf("%02x %02x ",(unsigned char)buffer[i],
					(unsigned char)buffer[i+1]);
#endif
	}

#ifdef CS_DEBUG
	printf("\n");
#endif

	return 0;
}

static int
get_eeprom_cksum(int off, int len, int *buffer)
{
	int i,cksum=0;

	for (i=0;i<len;i++)
		cksum+=buffer[i];
	cksum &= 0xffff;
	if (cksum==0)
		return 0;
	return -1;
}

static int
wait_eeprom_ready(struct cs_softc *sc)
{
	int timeout=1000;
	DELAY ( 30000 );	/* XXX should we do some checks here ? */
	return 0;
}

static void
control_dc_dc(struct cs_softc *sc, int on_not_off)
{
	unsigned int self_control = HCB1_ENBL;

	if (((sc->adapter_cnf & A_CNF_DC_DC_POLARITY)!=0) ^ on_not_off)
		self_control |= HCB1;
	else
		self_control &= ~HCB1;
	cs_writereg( sc->nic_addr, PP_SelfCTL, self_control );

	DELAY( 500000 );
}


static int
cs_duplex_auto(struct cs_softc *sc)
{
        int i, error=0, unit=sc->arpcom.ac_if.if_unit;
        
        cs_writereg(sc->nic_addr, PP_AutoNegCTL,
                    RE_NEG_NOW | ALLOW_FDX | AUTO_NEG_ENABLE );
        for (i=0; cs_readreg(sc->nic_addr,PP_AutoNegST)&AUTO_NEG_BUSY; i++) {
                if (i > 40000) {
                        printf(CS_NAME"%1d: full/half duplex "
                               "auto negotiation timeout\n", unit);
			error = ETIMEDOUT;
                        break;
                }
                DELAY(1000);
        }
        DELAY( 1000000 );
	return error;
}

static int
enable_tp(struct cs_softc *sc)
{
	int i;
	int unit = sc->arpcom.ac_if.if_unit;

	cs_writereg(sc->nic_addr, PP_LineCTL, sc->line_ctl & ~AUI_ONLY);
	control_dc_dc(sc, 0);
	DELAY( 150000 );

	if ((cs_readreg(sc->nic_addr, PP_LineST) & LINK_OK)==0) {
		printf(CS_NAME"%1d: failed to enable TP\n", unit);
                return EINVAL;
	}

	return 0;
}

/*
 * XXX This was rewritten from Linux driver without any tests.
 */             
static int
send_test_pkt(struct cs_softc *sc)
{
	int unit = sc->arpcom.ac_if.if_unit;
	char test_packet[] = { 0,0,0,0,0,0, 0,0,0,0,0,0,
				0, 46,  /* A 46 in network order */
				0, 0,   /* DSAP=0 & SSAP=0 fields */
				0xf3, 0 /* Control (Test Req + P bit set) */ };

	cs_writereg(sc->nic_addr, PP_LineCTL,
		cs_readreg(sc->nic_addr, PP_LineCTL) | SERIAL_TX_ON );
	bcopy(test_packet,
			sc->arpcom.ac_enaddr, ETHER_ADDR_LEN);
	bcopy(test_packet+ETHER_ADDR_LEN,
			sc->arpcom.ac_enaddr, ETHER_ADDR_LEN);
	outw(sc->nic_addr + TX_CMD_PORT, sc->send_cmd);
	outw(sc->nic_addr + TX_LEN_PORT, sizeof(test_packet));

	/* Wait for chip to allocate memory */
	DELAY(50000);
	if (!(cs_readreg(sc->nic_addr, PP_BusST) & READY_FOR_TX_NOW))
		return 0;

	outsw(sc->nic_addr + TX_FRAME_PORT, test_packet, sizeof(test_packet));

	DELAY(30000);

	if ((cs_readreg(sc->nic_addr,PP_TxEvent) & TX_SEND_OK_BITS) == TX_OK)
		return 1;
	return 0;
}

/*
 * XXX This was rewritten from Linux driver without any tests.
 */
static int
enable_aui(struct cs_softc *sc)
{
	int unit = sc->arpcom.ac_if.if_unit;

	control_dc_dc(sc, 0);
	cs_writereg(sc->nic_addr, PP_LineCTL,
		(sc->line_ctl & ~AUTO_AUI_10BASET) | AUI_ONLY);

	if (!send_test_pkt(sc)) {
		printf(CS_NAME"%1d failed to enable AUI\n", unit);
		return EINVAL;
        }
        return 0;
}

/*
 * XXX This was rewritten from Linux driver without any tests.
 */             
static int
enable_bnc(struct cs_softc *sc)
{
	int unit = sc->arpcom.ac_if.if_unit;

	control_dc_dc(sc, 1);
	cs_writereg(sc->nic_addr, PP_LineCTL,
		(sc->line_ctl & ~AUTO_AUI_10BASET) | AUI_ONLY);

	if (!send_test_pkt(sc)) {
		printf(CS_NAME"%1d failed to enable BNC\n", unit);
		return EINVAL;
        }
        return 0;
}

static int
cs_cs89x0_probe(struct cs_softc *sc, u_int *dev_irq,
			int *dev_drq, int iobase, int unit, int flags)
{
	unsigned rev_type = 0;
	int i, irq=0, result;
	int eeprom_buff[CHKSUM_LEN];
	int chip_type, pp_isaint, pp_isadma;
	char chip_revision;

	if ((inw(iobase+ADD_PORT) & ADD_MASK) != ADD_SIG) {
		/* Chip not detected. Let's try to reset it */
		if (bootverbose)
			printf(CS_NAME"%1d: trying to reset the chip.\n", unit);
		outw(iobase+ADD_PORT, PP_SelfCTL);
		i = inw(iobase+DATA_PORT);
		outw(iobase+ADD_PORT, PP_SelfCTL);
		outw(iobase+DATA_PORT, i | POWER_ON_RESET);
		if ((inw(iobase+ADD_PORT) & ADD_MASK) != ADD_SIG)
			return 0;
	}

	outw(iobase+ADD_PORT, PP_ChipID);
	if (inw(iobase+DATA_PORT) != CHIP_EISA_ID_SIG)
		return 0;

	rev_type = cs_readreg(iobase, PRODUCT_ID_ADD);
	chip_type = rev_type & ~REVISON_BITS;
	chip_revision = ((rev_type & REVISON_BITS) >> 8) + 'A';

	sc->nic_addr = iobase;
	sc->chip_type = chip_type;
	if(chip_type==CS8900) {
		pp_isaint = PP_CS8900_ISAINT;
		pp_isadma = PP_CS8900_ISADMA;
		sc->send_cmd = TX_CS8900_AFTER_ALL;
	} else {
		pp_isaint = PP_CS8920_ISAINT;
		pp_isadma = PP_CS8920_ISADMA;
		sc->send_cmd = TX_CS8920_AFTER_ALL;
	}

        /*
         * Clear some fields so that fail of EEPROM will left them clean
         */
        sc->auto_neg_cnf = 0;
        sc->adapter_cnf  = 0;
        sc->isa_config   = 0;
        
	/*
	 * EEPROM
	 */
	if((cs_readreg(iobase, PP_SelfST) & EEPROM_PRESENT) == 0) {
		printf(CS_NAME"%1d: No EEPROM, assuming defaults.\n",
			unit);
	} else {
		if (get_eeprom_data(sc,START_EEPROM_DATA,CHKSUM_LEN, eeprom_buff)<0) {
			 printf(CS_NAME"%1d: EEPROM read failed, "
				"assuming defaults..\n", unit);
		} else {
			if (get_eeprom_cksum(START_EEPROM_DATA,CHKSUM_LEN, eeprom_buff)<0) {
				printf( CS_NAME"%1d: EEPROM cheksum bad, "
					"assuming defaults..\n", unit );
			} else {
                                sc->auto_neg_cnf =
                                        eeprom_buff[AUTO_NEG_CNF_OFFSET/2];
                                sc->adapter_cnf =
                                        eeprom_buff[ADAPTER_CNF_OFFSET/2];
                                sc->isa_config =
                                        eeprom_buff[ISA_CNF_OFFSET/2];

                                for (i=0; i<ETHER_ADDR_LEN/2; i++) {
                                        sc->arpcom.ac_enaddr[i*2]=
                                                eeprom_buff[i];
                                        sc->arpcom.ac_enaddr[i*2+1]=
                                                eeprom_buff[i] >> 8;
                                }

                                /*
                                 * If no interrupt specified (or "?"),
                                 * use what the board tells us.
                                 */
                                if (*dev_irq <= 0) {
                                        irq = sc->isa_config & INT_NO_MASK;
                                        if (chip_type==CS8900) {
						switch(irq) {
                                                case 0: irq=10; break;
                                                case 1: irq=11; break;
                                                case 2: irq=12; break;
                                                case 3: irq=5;  break;
                                                default: printf(CS_NAME"%1d: invalid irq in EEPROM.\n",unit);
						}
						if (irq!=0)
							*dev_irq=(u_short)(1<<irq);
					} else {
						if (irq!=0 && irq<=CS8920_NO_INTS)
							*dev_irq=(u_short)(1<<irq);
					}
                                }
			}
                }
        }

        if ((irq=ffs(*dev_irq))) {
                irq--;
                if (chip_type == CS8900) {
			switch(irq) {
                        case  5: irq = 3; break;
                        case 10: irq = 0; break;
                        case 11: irq = 1; break;
                        case 12: irq = 2; break;
                        default: printf(CS_NAME"%1d: invalid irq\n", unit);
                                return 0;
			}
                } else {
                        if (irq > CS8920_NO_INTS) {
                                printf(CS_NAME"%1d: invalid irq\n", unit);
                                return 0;
                        }
                }
                cs_writereg(iobase, pp_isaint, irq);
	} else {
	       	printf(CS_NAME"%1d: invalid irq\n", unit);
                return 0;
        }
        
        /*
         * Temporary disabled
         *
        if (drq>0)
		cs_writereg(iobase, pp_isadma, drq);
	else {
		printf( CS_NAME"%1d: incorrect drq\n", unit );
		return 0;
	}
        */

	if (bootverbose)
		 printf(CS_NAME"%1d: model CS89%c0%s rev %c\n"
			CS_NAME"%1d: media%s%s%s\n"
			CS_NAME"%1d: irq %d drq %d\n",
			unit,
			chip_type==CS8900 ? '0' : '2',
			chip_type==CS8920M ? "M" : "",
			chip_revision,
			unit,
			(sc->adapter_cnf & A_CNF_10B_T) ? " TP"  : "",
			(sc->adapter_cnf & A_CNF_AUI)   ? " AUI" : "",
			(sc->adapter_cnf & A_CNF_10B_2) ? " BNC" : "",
			unit, (int)*dev_irq, (int)*dev_drq);

        if ((sc->adapter_cnf & A_CNF_EXTND_10B_2) &&
            (sc->adapter_cnf & A_CNF_LOW_RX_SQUELCH))
                sc->line_ctl = LOW_RX_SQUELCH;
        else
                sc->line_ctl = 0;

        
	return PP_ISAIOB;
}

/*
 * Determine if the device is present
 *
 *   on entry:
 * 	a pointer to an isa_device struct
 *   on exit:
 *	NULL if device not found
 *	or # of i/o addresses used (if found)
 */
static int
cs_probe(struct isa_device *dev)
{
	int nports;

	struct cs_softc *sc=&cs_softc[dev->id_unit];

	nports=cs_cs89x0_probe(sc, &(dev->id_irq), &(dev->id_drq),
			(dev->id_iobase), (dev->id_unit), (dev->id_flags));

	if (nports)
		return (nports);

	return (0);
}

/*
 * Install the interface into kernel networking data structures
 */
static int
cs_attach(struct cs_softc *sc, int unit, int flags)
{
        int media=0;
/*	struct cs_softc *sc = &cs_softc[dev->id_unit]; */
	struct ifnet *ifp = &(sc->arpcom.ac_if);

	if (!ifp->if_name) {
		ifp->if_softc=sc;
		ifp->if_unit=unit;
		ifp->if_name=csdriver.name;
		ifp->if_output=ether_output;
		ifp->if_start=cs_start;
		ifp->if_ioctl=cs_ioctl;
		ifp->if_watchdog=cs_watchdog;
		ifp->if_init=cs_init;
		ifp->if_snd.ifq_maxlen= IFQ_MAXLEN;
		/*
                 *  MIB DATA
                 */
                /*
		ifp->if_linkmib=&sc->mibdata;
		ifp->if_linkmiblen=sizeof sc->mibdata;
                */

		ifp->if_flags=(IFF_BROADCAST | IFF_SIMPLEX | IFF_MULTICAST );

		/*
		 * this code still in progress (DMA support)
		 *

		sc->recv_ring=malloc(CS_DMA_BUFFER_SIZE<<1, M_DEVBUF, M_NOWAIT);
		if (sc->recv_ring == NULL) {
			log(LOG_ERR,CS_NAME
			"%d: Couldn't allocate memory for NIC\n", unit);
			return(0);
		}
		if ((sc->recv_ring-(sc->recv_ring & 0x1FFFF))
		    < (128*1024-CS_DMA_BUFFER_SIZE))
		    sc->recv_ring+=16*1024;

		*/

		sc->buffer=malloc(ETHER_MAX_LEN-ETHER_CRC_LEN,M_DEVBUF,M_NOWAIT);
		if (sc->buffer == NULL) {
                        printf(CS_NAME"%d: Couldn't allocate memory for NIC\n",
                               unit);
                        return(0);
		}

		/*
		 * Initialize the media structures.
		 */
		ifmedia_init(&sc->media, 0, cs_mediachange, cs_mediastatus);

		if (sc->adapter_cnf & A_CNF_10B_T) {
			ifmedia_add(&sc->media, IFM_ETHER|IFM_10_T, 0, NULL);
			if (sc->chip_type != CS8900) {
				ifmedia_add(&sc->media,
					IFM_ETHER|IFM_10_T|IFM_FDX, 0, NULL);
				ifmedia_add(&sc->media,
					IFM_ETHER|IFM_10_T|IFM_HDX, 0, NULL);
			}
		} 

		if (sc->adapter_cnf & A_CNF_10B_2)
			ifmedia_add(&sc->media, IFM_ETHER|IFM_10_2, 0, NULL);

		if (sc->adapter_cnf & A_CNF_AUI)
			ifmedia_add(&sc->media, IFM_ETHER|IFM_10_5, 0, NULL);

                if (sc->adapter_cnf & A_CNF_MEDIA)
                        ifmedia_add(&sc->media, IFM_ETHER|IFM_AUTO, 0, NULL);

                /* Set default media from EEPROM */
                switch (sc->adapter_cnf & A_CNF_MEDIA_TYPE) {
                case A_CNF_MEDIA_AUTO:  media = IFM_ETHER|IFM_AUTO; break;
                case A_CNF_MEDIA_10B_T: media = IFM_ETHER|IFM_10_T; break;
                case A_CNF_MEDIA_10B_2: media = IFM_ETHER|IFM_10_2; break;
                case A_CNF_MEDIA_AUI:   media = IFM_ETHER|IFM_10_5; break;
                default: printf(CS_NAME"%d: adapter has no media\n", unit);
                }
                ifmedia_set(&sc->media, media);
		cs_mediaset(sc, media);

		if_attach(ifp);
		cs_stop( sc );
		ether_ifattach(ifp);
	}

	if (bootverbose)
		printf(CS_NAME"%d: ethernet address %6D\n",
		       ifp->if_unit, sc->arpcom.ac_enaddr, ":");

#if NBPFILTER > 0
	bpfattach(ifp, DLT_EN10MB, sizeof (struct ether_header));
#endif
	return 1;
}

static int
cs_attach_isa(struct isa_device *dev)
{
        int unit=dev->id_unit;
        struct cs_softc *sc=&cs_softc[unit];
        int flags=dev->id_flags;

        return cs_attach(sc, unit, flags);
}

/*
 * Initialize the board
 */
static void
cs_init(void *xsc)
{
	struct cs_softc *sc=(struct cs_softc *)xsc;
	struct ifnet *ifp = &sc->arpcom.ac_if;
	int i, s, result, rx_cfg;

	/* address not known */
	if (TAILQ_EMPTY(&ifp->if_addrhead)) /* unlikely? XXX */
		return;

	/*
	 * reset whatchdog timer
	 */
	ifp->if_timer=0;
	sc->buf_len = 0;
	
	s=splimp();

	/*
	 * Hardware initialization of cs
	 */

	/* Enable receiver and transmitter */
	cs_writereg(sc->nic_addr, PP_LineCTL,
		    sc->line_ctl | SERIAL_RX_ON | SERIAL_TX_ON);

	/* Configure the receiver mode */
	cs_setmode(sc);

	/*
	 * This defines what type of frames will cause interrupts
	 * Bad frames should generate interrupts so that the driver
	 * could track statistics of discarded packets
	 */
        rx_cfg = RX_OK_ENBL | RX_CRC_ERROR_ENBL | RX_RUNT_ENBL |
		 RX_EXTRA_DATA_ENBL;
	if (sc->isa_config & STREAM_TRANSFER)
		rx_cfg |= RX_STREAM_ENBL;
	cs_writereg(sc->nic_addr, PP_RxCFG, rx_cfg);

	cs_writereg(sc->nic_addr, PP_TxCFG, TX_LOST_CRS_ENBL |
		    TX_SQE_ERROR_ENBL | TX_OK_ENBL | TX_LATE_COL_ENBL |
		    TX_JBR_ENBL | TX_ANY_COL_ENBL | TX_16_COL_ENBL);

	cs_writereg(sc->nic_addr, PP_BufCFG, READY_FOR_TX_ENBL |
		    RX_MISS_COUNT_OVRFLOW_ENBL | TX_COL_COUNT_OVRFLOW_ENBL |
		    TX_UNDERRUN_ENBL /*| RX_DMA_ENBL*/);

        /* Write MAC address into IA filter */
        for (i=0; i<ETHER_ADDR_LEN/2; i++)
                cs_writereg(sc->nic_addr, PP_IA+i*2,
                            sc->arpcom.ac_enaddr[i*2] |
                            (sc->arpcom.ac_enaddr[i*2+1] << 8) );

	/*
	 * Now enable everything
	 */
/*
#ifdef	CS_USE_64K_DMA
	cs_writereg(sc->nic_addr, PP_BusCTL, ENABLE_IRQ | RX_DMA_SIZE_64K);
        #else

        cs_writereg(sc->nic_addr, PP_BusCTL, ENABLE_IRQ);
#endif
*/
	cs_writereg(sc->nic_addr, PP_BusCTL, ENABLE_IRQ);
	
	/*
	 * Set running and clear output active flags
	 */
	sc->arpcom.ac_if.if_flags |= IFF_RUNNING;
	sc->arpcom.ac_if.if_flags &= ~IFF_OACTIVE;

	/*
	 * Start sending process
	 */
	cs_start(ifp);

	(void) splx(s);
}

/*
 * Get the packet from the board and send it to the upper layer
 * via ether_input().
 */
static int
cs_get_packet(struct cs_softc *sc)
{
	struct ifnet *ifp = &(sc->arpcom.ac_if);
	int iobase = sc->nic_addr, status, length;
	struct ether_header *eh;
	struct mbuf *m;

#ifdef CS_DEBUG
	int i;
#endif

	status = inw(iobase + RX_FRAME_PORT);
	length = inw(iobase + RX_FRAME_PORT);

#ifdef CS_DEBUG
	printf(CS_NAME"%1d: rcvd: stat %x, len %d\n",
		ifp->if_unit, status, length);
#endif

	if (!(status & RX_OK)) {
#ifdef CS_DEBUG
		printf(CS_NAME"%1d: bad pkt stat %x\n", ifp->if_unit, status);
#endif
		ifp->if_ierrors++;
		return -1;
	}

	MGETHDR(m, M_DONTWAIT, MT_DATA);
	if (m==NULL)
		return -1;

	if (length > MHLEN) {
		MCLGET(m, M_DONTWAIT);
		if (!(m->m_flags & M_EXT)) {
			m_freem(m);
			return -1;
		}
	}

	/* Initialize packet's header info */
	m->m_pkthdr.rcvif = ifp;
	m->m_pkthdr.len = length;
	m->m_len = length;

	/* Get the data */
	insw(iobase + RX_FRAME_PORT, m->m_data, (length+1)>>1);

	eh = mtod(m, struct ether_header *);

#if NBPFILTER > 0
	if (ifp->if_bpf)
		bpf_mtap(ifp, m);
#endif

#ifdef CS_DEBUG
	for (i=0;i<length;i++)
	     printf(" %02x",(unsigned char)*((char *)(m->m_data+i)));
	printf( "\n" );
#endif

	if (status & (RX_IA | RX_BROADCAST) || 
	    (ifp->if_flags & IFF_MULTICAST && status & RX_HASHED)) {
		m->m_pkthdr.len -= sizeof(struct ether_header);
		m->m_len -= sizeof(struct ether_header);
		m->m_data += sizeof(struct ether_header);

		/* Feed the packet to the upper layer */
		ether_input(ifp, eh, m);

		ifp->if_ipackets++;

		if (length==ETHER_MAX_LEN-ETHER_CRC_LEN)
                        DELAY( CS_WAIT_NEXT_PACKET );
	} else {
		m_freem(m);
	}

	return 0;
}

/*
 * Software calls interrupt handler
 */
static void
csintr_sc(struct cs_softc *sc, int unit)
{
	struct ifnet *ifp = &(sc->arpcom.ac_if);
	int status, s;

#ifdef CS_DEBUG
	printf(CS_NAME"%1d: Interrupt.\n", unit);
#endif

	while ((status=cs_readword(sc->nic_addr, ISQ_PORT))) {

#ifdef CS_DEBUG
		printf( CS_NAME"%1d:from ISQ: %04x\n", unit, status );
#endif

		switch (status & ISQ_EVENT_MASK) {
                case ISQ_RECEIVER_EVENT:
                        cs_get_packet(sc);
                        break;

                case ISQ_TRANSMITTER_EVENT:
                        if (status & TX_OK)
                                ifp->if_opackets++;
                        else
                                ifp->if_oerrors++;
                        ifp->if_flags &= ~IFF_OACTIVE;
                        ifp->if_timer = 0;
                        break;

                case ISQ_BUFFER_EVENT:
                        if (status & READY_FOR_TX) {
                                ifp->if_flags &= ~IFF_OACTIVE;
                                ifp->if_timer = 0;
                        }

                        if (status & TX_UNDERRUN) {
                                ifp->if_flags &= ~IFF_OACTIVE;
                                ifp->if_timer = 0;
                                ifp->if_oerrors++;
                        }
                        break;

                case ISQ_RX_MISS_EVENT:
                        ifp->if_ierrors+=(status>>6);
                        break;

                case ISQ_TX_COL_EVENT:
                        ifp->if_collisions+=(status>>6);
                        break;
                }
        }

        if (!(ifp->if_flags & IFF_OACTIVE)) {
                cs_start(ifp);
        }
}

/*
 * Handle interrupts
 */
void
csintr(int unit)
{
	struct cs_softc *sc = &cs_softc[unit];

	csintr_sc(sc, unit);
}

/*
 * Save the data in buffer
 */

static void
cs_write_mbufs( struct cs_softc *sc, struct mbuf *m )
{
	int len;
	struct mbuf *mp;
	unsigned char *data, *buf;

	for (mp=m, buf=sc->buffer, sc->buf_len=0; mp != NULL; mp=mp->m_next) {
		len = mp->m_len;

		/*
		 * Ignore empty parts
		 */
		if (!len)
		continue;

		/*
		 * Find actual data address
		 */
		data = mtod(mp, caddr_t);

		bcopy((caddr_t) data, (caddr_t) buf, len);
		buf += len;
		sc->buf_len += len;
	}
}


static void
cs_xmit_buf( struct cs_softc *sc )
{
	outsw(sc->nic_addr+TX_FRAME_PORT, sc->buffer, (sc->buf_len+1)>>1);
	sc->buf_len = 0;
}

static void
cs_start(struct ifnet *ifp)
{
	int s, length;
	struct mbuf *m, *mp;
	struct cs_softc *sc = ifp->if_softc;

	s = splimp();

	for (;;) {
		if (sc->buf_len)
			length = sc->buf_len;
		else {
			IF_DEQUEUE( &ifp->if_snd, m );

			if (m==NULL) {
				(void) splx(s);
				return;
			}

			for (length=0, mp=m; mp != NULL; mp=mp->m_next)
				length += mp->m_len;

			/* Skip zero-length packets */
			if (length == 0) {
				m_freem(m);
				continue;
			}

			cs_write_mbufs(sc, m);

#if NBPFILTER > 0
			if (ifp->if_bpf) {
				bpf_mtap(ifp, m);
			}
#endif

			m_freem(m);
		}

		/*
		 * Issue a SEND command
		 */
		outw(sc->nic_addr+TX_CMD_PORT, sc->send_cmd);
		outw(sc->nic_addr+TX_LEN_PORT, length );

		/*
		 * If there's no free space in the buffer then leave
		 * this packet for the next time: indicate output active
		 * and return.
		 */
		if (!(cs_readreg(sc->nic_addr, PP_BusST) & READY_FOR_TX_NOW)) {
			ifp->if_timer = sc->buf_len;
			(void) splx(s);
			ifp->if_flags |= IFF_OACTIVE;
			return;
		}

               	cs_xmit_buf(sc);

		/*
		 * Set the watchdog timer in case we never hear
		 * from board again. (I don't know about correct
		 * value for this timeout)
		 */
		ifp->if_timer = length;

		(void) splx(s);
		ifp->if_flags |= IFF_OACTIVE;
		return;
	}
}

/*
 * Stop everything on the interface
 */
static void
cs_stop(struct cs_softc *sc)
{
	int s = splimp();

	cs_writereg(sc->nic_addr, PP_RxCFG, 0);
	cs_writereg(sc->nic_addr, PP_TxCFG, 0);
	cs_writereg(sc->nic_addr, PP_BufCFG, 0);
	cs_writereg(sc->nic_addr, PP_BusCTL, 0);

	sc->arpcom.ac_if.if_flags &= ~(IFF_RUNNING | IFF_OACTIVE);
	sc->arpcom.ac_if.if_timer = 0;

	(void) splx(s);
}

/*
 * Reset the interface
 */
static void
cs_reset(struct cs_softc *sc)
{
	cs_stop(sc);
	cs_init(sc);
}

static void
cs_setmode(struct cs_softc *sc)
{
	struct ifnet *ifp = &(sc->arpcom.ac_if);
	int rx_ctl;

	/* Stop the receiver while changing filters */
	cs_writereg(sc->nic_addr, PP_LineCTL, 
			cs_readreg(sc->nic_addr, PP_LineCTL) & ~SERIAL_RX_ON);

	if (ifp->if_flags & IFF_PROMISC) {
		/* Turn on promiscuous mode. */
		rx_ctl = RX_OK_ACCEPT | RX_PROM_ACCEPT;
	} else {
		if (ifp->if_flags & IFF_MULTICAST) {
			/* Allow receiving frames with multicast addresses */
			rx_ctl = RX_IA_ACCEPT | RX_BROADCAST_ACCEPT |
				 RX_OK_ACCEPT | RX_MULTCAST_ACCEPT;
			/*
			 * Here the reconfiguration of chip's multicast
			 * filters should be done but I've no idea about
			 * hash transformation in this chip. If you can
			 * add this code or describe me the transformation
			 * I'd be very glad.
			 */
		} else {
			/*
			 * Receive only good frames addressed for us and
			 * good broadcasts.
			 */
			rx_ctl = RX_IA_ACCEPT | RX_BROADCAST_ACCEPT |
				 RX_OK_ACCEPT;
		}
	}

	/* Set up the filter */
	cs_writereg(sc->nic_addr, PP_RxCTL, RX_DEF_ACCEPT | RX_MULTCAST_ACCEPT);

	/* Turn on receiver */
	cs_writereg(sc->nic_addr, PP_LineCTL,
			cs_readreg(sc->nic_addr, PP_LineCTL) | SERIAL_RX_ON);
}

static int
cs_ioctl(register struct ifnet *ifp, u_long command, caddr_t data)
{
	struct cs_softc *sc=ifp->if_softc;
	struct ifreq *ifr = (struct ifreq *)data;
	int s,error=0;

#ifdef CS_DEBUG
	printf(CS_NAME"%d: ioctl(%x)\n",sc->arpcom.ac_if.if_unit,command);
#endif

	s=splimp();

	switch (command) {
	case SIOCSIFADDR:
	case SIOCGIFADDR:
	case SIOCSIFMTU:
		ether_ioctl(ifp, command, data);
		break;

	case SIOCSIFFLAGS:
		/*
		 * Switch interface state between "running" and
		 * "stopped", reflecting the UP flag.
                 */
                if (sc->arpcom.ac_if.if_flags & IFF_UP) {
                        if ((sc->arpcom.ac_if.if_flags & IFF_RUNNING)==0) {
                                cs_init(sc);
                        }
                } else {
                        if ((sc->arpcom.ac_if.if_flags & IFF_RUNNING)!=0) {
                                cs_stop(sc);
                        }
		}
		/*
		 * Promiscuous and/or multicast flags may have changed,
		 * so reprogram the multicast filter and/or receive mode.
		 *
		 * See note about multicasts in cs_setmode
		 */
		cs_setmode(sc);
		break;

	case SIOCADDMULTI:
	case SIOCDELMULTI:
	    /*
	     * Multicast list has changed; set the hardware filter
	     * accordingly.
	     *
	     * See note about multicasts in cs_setmode
	     */
	    cs_setmode(sc);
	    error = 0;
	    break;

        case SIOCSIFMEDIA:
        case SIOCGIFMEDIA:
                error = ifmedia_ioctl(ifp, ifr, &sc->media, command);
                break;

        default:
		error = EINVAL;
        }

	(void) splx(s);
	return error;
}

/*
 * Device timeout/watchdog routine. Entered if the device neglects to
 * generate an interrupt after a transmit has been started on it.
 */
static void
cs_watchdog(struct ifnet *ifp)
{
	struct cs_softc *sc = &cs_softc[ifp->if_unit];

	ifp->if_oerrors++;
	log(LOG_ERR, CS_NAME"%d: device timeout\n", ifp->if_unit);

	/* Reset the interface */
	if (ifp->if_flags & IFF_UP)
		cs_reset(sc);
	else
		cs_stop(sc);
}

static int
cs_mediachange(struct ifnet *ifp)
{
	struct cs_softc *sc = ifp->if_softc;
	struct ifmedia *ifm = &sc->media;

	if (IFM_TYPE(ifm->ifm_media) != IFM_ETHER)
		return EINVAL;

	return cs_mediaset(sc, ifm->ifm_media);
}

static void
cs_mediastatus(struct ifnet *ifp, struct ifmediareq *ifmr)
{
	int line_status;
	struct cs_softc *sc = ifp->if_softc;

	ifmr->ifm_active = IFM_ETHER;
	line_status = cs_readreg(sc->nic_addr, PP_LineST);
	if (line_status & TENBASET_ON) {
		ifmr->ifm_active |= IFM_10_T;
		if (sc->chip_type != CS8900) {
			if (cs_readreg(sc->nic_addr, PP_AutoNegST) & FDX_ACTIVE)
				ifmr->ifm_active |= IFM_FDX;
			if (cs_readreg(sc->nic_addr, PP_AutoNegST) & HDX_ACTIVE)
				ifmr->ifm_active |= IFM_HDX;
		}
		ifmr->ifm_status = IFM_AVALID;
		if (line_status & LINK_OK)
			ifmr->ifm_status |= IFM_ACTIVE;
	} else {
		/*
		 * XXX I don't know if this is correct or not.
		 * If AUI will be reported instead of BNC
                 * then this is wrong.
		 */
		if (line_status & AUI_ON)
			ifmr->ifm_active |= IFM_10_5;
		else
			ifmr->ifm_active |= IFM_10_2;
#ifdef CS_BROKEN_BNC_DETECT
		printf(CS_NAME"%d: PP_LineST: %02x PP_SelfST: %02x\n",
				ifp->if_unit,line_status,
				cs_readreg(sc->nic_addr,PP_SelfST));
#endif
	}
}

static int
cs_mediaset(struct cs_softc *sc, int media)
{
        int error;

	/* Stop the receiver & transmitter */
	cs_writereg(sc->nic_addr, PP_LineCTL,
                    cs_readreg(sc->nic_addr, PP_LineCTL) &
		    ~(SERIAL_RX_ON | SERIAL_TX_ON));

#ifdef CS_DEBUG
	printf(CS_NAME"%d: cs_setmedia(%x)\n",sc->arpcom.ac_if.if_unit,media);
#endif

	switch (IFM_SUBTYPE(media)) {
	default:
	case IFM_AUTO:
		if (error=enable_tp(sc))
       		if (error=enable_bnc(sc))
		    error=enable_aui(sc);
		break;
	case IFM_10_T:
		if (error=enable_tp(sc))
			break;
		if (media & IFM_FDX)
			cs_duplex_full(sc);
		else if (media & IFM_HDX)
			cs_duplex_half(sc);
		else
			error = cs_duplex_auto(sc);
		break;
	case IFM_10_2:
		error = enable_bnc(sc);
		break;
	case IFM_10_5:
		error = enable_aui(sc);
		break;
	}

	/*
	 * Turn the transmitter & receiver back on
	 */
	cs_writereg(sc->nic_addr, PP_LineCTL,
		    cs_readreg( sc->nic_addr, PP_LineCTL ) |
		    SERIAL_RX_ON | SERIAL_TX_ON); 

	return error;
}


#if NPNP > 0

static struct cspnp_ids {
	u_long	vend_id;
	char 	*id_str;
} cspnp_ids[]= {
	{ 0x4060630e, "CSC6040" },
	{ 0x10104d24, "IBM EtherJet" },
	{ 0 }
};

static char *cs_pnp_probe(u_long, u_long);
static void cs_pnp_attach(u_long, u_long, char *, struct isa_device *);

struct pnp_device cs_pnp = {
	"CS8920 based PnP Ethernet",
	cs_pnp_probe,
	cs_pnp_attach,
	&cs_unit,
	&net_imask	/* imask */
};

DATA_SET (pnpdevice_set, cs_pnp);

struct csintr_list {
	struct cs_softc *sc;
	int unit;
	struct csintr_list *next;
};

static struct csintr_list *csintr_head;

static void csintr_pnp_add(struct cs_softc *sc, int unit);
static void csintr_pnp(int unit);

static void
csintr_pnp_add(struct cs_softc *sc, int unit)
{
    struct csintr_list *intr;

    if (!sc) return;

    intr = malloc (sizeof (*intr), M_DEVBUF, M_WAITOK);
    if (!intr) return;

    intr->sc = sc;
    intr->unit = unit;
    intr->next = csintr_head;
    csintr_head = intr;
}

/*
 * Interrupt handler for PNP installed card
 * We have to find the number of the card.
 */
static void
csintr_pnp(int unit)
{
    struct cs_softc *sc;
    struct csintr_list *intr;

    for (intr=csintr_head; intr; intr=intr->next) {
	    if (intr->unit == unit)
		csintr_sc(intr->sc, unit);
		break;
	}
}

static char *
cs_pnp_probe(u_long csn, u_long vend_id)
{
    struct cspnp_ids *ids;
    char	     *s=NULL;

    for(ids = cspnp_ids; ids->vend_id != 0; ids++) {
	if (vend_id == ids->vend_id) {
	    s = ids->id_str;
	    break;
	}
    }

    if (s) {
	struct pnp_cinfo d;
	int ldn = 0;

	read_pnp_parms(&d, ldn);
	if (d.enable == 0) {
	    printf("This is a %s, but LDN %d is disabled\n", s, ldn);
	    return NULL ;
	}
	return s;
    }

    return NULL ;
}

static void
cs_pnp_attach(u_long csn, u_long vend_id, char *name,
	struct isa_device *dev)
{

    struct pnp_cinfo d;
    int	ldn = 0;
    int iobase, unit, flags;
    u_short irq;
    short drq;
    struct isa_device *dvp;
    struct cs_softc *sc = malloc(sizeof *sc, M_DEVBUF, M_NOWAIT);

    if (read_pnp_parms ( &d , ldn ) == 0 ) {
	printf("failed to read pnp parms\n");
	return;
    }

    write_pnp_parms( &d, ldn );
    enable_pnp_card();

    iobase = dev->id_iobase = d.port[0];
    irq = dev->id_irq = (1 << d.irq[0] );
    drq = dev->id_drq = d.drq[0];
    dev->id_maddr = 0;
    dev->id_intr = csintr_pnp;
    flags = dev->id_flags = 0;
    unit = dev->id_unit;

    if (dev->id_driver == NULL) {
	dev->id_driver = &csdriver;
	dvp = find_isadev(isa_devtab_net, &csdriver, 0);
	if (dvp != NULL)
	dev->id_id = dvp->id_id;
    }

    if (!sc) return;

    bzero(sc, sizeof *sc);
    if (cs_cs89x0_probe(sc, &irq, &drq, iobase, unit, flags) == 0
	|| cs_attach(sc, unit, flags) == 0) {
	    free(sc, M_DEVBUF);
    } else {
	if ((irq != dev->id_irq)
	    || (drq != dev->id_drq)
	    || (iobase != dev->id_iobase)
	    || (unit != dev->id_unit)
	    || (flags != dev->id_flags)
		) {
		printf("failed to pnp card parametars\n");
	}
    }
    csintr_pnp_add(sc, dev->id_unit);
}
#endif /* NPNP */
