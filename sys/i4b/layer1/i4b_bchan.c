/*
 * Copyright (c) 1997, 1999 Hellmuth Michaelis. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
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
 *---------------------------------------------------------------------------
 *
 *	i4b_bchan.c - B channel handling L1 procedures
 *	----------------------------------------------
 *
 *	$Id: i4b_bchan.c,v 1.30 1999/02/14 19:51:01 hm Exp $
 *
 *      last edit-date: [Sun Feb 14 10:25:27 1999]
 *
 *---------------------------------------------------------------------------*/

#if defined(__FreeBSD__)
#include "isic.h"
#else
#define NISIC 1
#endif

#if NISIC > 0

#include <sys/param.h>
#if defined(__FreeBSD__) && __FreeBSD__ >= 3
#include <sys/ioccom.h>
#else
#include <sys/ioctl.h>
#endif
#include <sys/kernel.h>
#include <sys/systm.h>
#include <sys/mbuf.h>
#include <machine/stdarg.h>

#ifdef __FreeBSD__
#include <machine/clock.h>
#include <i386/isa/isa_device.h>
#else
#ifndef __bsdi__
#include <machine/bus.h>
#endif
#include <sys/device.h>
#endif

#include <sys/socket.h>
#include <net/if.h>

#ifdef __FreeBSD__
#include <machine/i4b_debug.h>
#include <machine/i4b_ioctl.h>
#include <machine/i4b_trace.h>
#else
#include <i4b/i4b_debug.h>
#include <i4b/i4b_ioctl.h>
#include <i4b/i4b_trace.h>
#endif

#include <i4b/layer1/i4b_l1.h>
#include <i4b/layer1/i4b_isac.h>
#include <i4b/layer1/i4b_hscx.h>

#include <i4b/include/i4b_l1l2.h>
#include <i4b/include/i4b_mbuf.h>
#include <i4b/include/i4b_global.h>

#ifdef __FreeBSD__
static void isic_bchannel_start(int unit, int h_chan);
static void isic_bchannel_stat(int unit, int h_chan, bchan_statistics_t *bsp);
#else
static void isic_bchannel_start __P((int unit, int h_chan));
static void isic_bchannel_stat __P((int unit, int h_chan, bchan_statistics_t *bsp));
#endif

static void isic_set_linktab(int unit, int channel, drvr_link_t *dlt);
static isdn_link_t *isic_ret_linktab(int unit, int channel);

/*---------------------------------------------------------------------------*
 *	initialize one B channels rx/tx data structures and init/deinit HSCX
 *---------------------------------------------------------------------------*/
void
isic_bchannel_setup(int unit, int h_chan, int bprot, int activate)
{
#ifdef __FreeBSD__
	struct isic_softc *sc = &isic_sc[unit];
#else
	struct isic_softc *sc = isic_find_sc(unit);
#endif
	isic_Bchan_t *chan = &sc->sc_chan[h_chan];

	int s = SPLI4B();
	
	if(activate == 0)
	{
		/* deactivation */
		isic_hscx_init(sc, h_chan, activate);
	}
		
	DBGL1(L1_BCHAN, "isic_bchannel_setup", ("unit=%d, channel=%d, %s\n",
		sc->sc_unit, h_chan, activate ? "activate" : "deactivate"));

	/* general part */

	chan->unit = sc->sc_unit;	/* unit number */
	chan->channel = h_chan;	/* B channel */
	chan->bprot = bprot;		/* B channel protocol */
	chan->state = HSCX_IDLE;	/* B channel state */

	/* receiver part */

	i4b_Bcleanifq(&chan->rx_queue);	/* clean rx queue */

	chan->rx_queue.ifq_maxlen = IFQ_MAXLEN;

	chan->rxcount = 0;		/* reset rx counter */
	
	i4b_Bfreembuf(chan->in_mbuf);	/* clean rx mbuf */

	chan->in_mbuf = NULL;		/* reset mbuf ptr */
	chan->in_cbptr = NULL;		/* reset mbuf curr ptr */
	chan->in_len = 0;		/* reset mbuf data len */
	
	/* transmitter part */

	i4b_Bcleanifq(&chan->tx_queue);	/* clean tx queue */

	chan->tx_queue.ifq_maxlen = IFQ_MAXLEN;
	
	chan->txcount = 0;		/* reset tx counter */
	
	i4b_Bfreembuf(chan->out_mbuf_head);	/* clean tx mbuf */

	chan->out_mbuf_head = NULL;	/* reset head mbuf ptr */
	chan->out_mbuf_cur = NULL;	/* reset current mbuf ptr */	
	chan->out_mbuf_cur_ptr = NULL;	/* reset current mbuf data ptr */
	chan->out_mbuf_cur_len = 0;	/* reset current mbuf data cnt */
	
	if(activate != 0)
	{
		/* activation */
		isic_hscx_init(sc, h_chan, activate);
	}

	splx(s);
}

/*---------------------------------------------------------------------------*
 *	start transmission on a b channel
 *---------------------------------------------------------------------------*/
static void
isic_bchannel_start(int unit, int h_chan)
{
#ifdef __FreeBSD__
	struct isic_softc *sc = &isic_sc[unit];
#else
	struct isic_softc *sc = isic_find_sc(unit);
#endif

	register isic_Bchan_t *chan = &sc->sc_chan[h_chan];
	register int next_len;
	register int len;

	int s;
	int activity = -1;
	int cmd = 0;

	s = SPLI4B();				/* enter critical section */
	if(chan->state & HSCX_TX_ACTIVE)	/* already running ? */
	{
		splx(s);
		return;				/* yes, leave */
	}

	/* get next mbuf from queue */
	
	IF_DEQUEUE(&chan->tx_queue, chan->out_mbuf_head);
	
	if(chan->out_mbuf_head == NULL)		/* queue empty ? */
	{
		splx(s);			/* leave critical section */
		return;				/* yes, exit */
	}

	/* init current mbuf values */
	
	chan->out_mbuf_cur = chan->out_mbuf_head;
	chan->out_mbuf_cur_len = chan->out_mbuf_cur->m_len;
	chan->out_mbuf_cur_ptr = chan->out_mbuf_cur->m_data;	
	
	/* activity indicator for timeout handling */

	if(chan->bprot == BPROT_NONE)
	{
		if(!(isic_hscx_silence(chan->out_mbuf_cur->m_data, chan->out_mbuf_cur->m_len)))
			activity = ACT_TX;
	}
	else
	{
		activity = ACT_TX;
	}

	chan->state |= HSCX_TX_ACTIVE;		/* we start transmitting */
	
	if(sc->sc_trace & TRACE_B_TX)	/* if trace, send mbuf to trace dev */
	{
		i4b_trace_hdr_t hdr;
		hdr.unit = unit;
		hdr.type = (h_chan == HSCX_CH_A ? TRC_CH_B1 : TRC_CH_B2);
		hdr.dir = FROM_TE;
		hdr.count = ++sc->sc_trace_bcount;
		MICROTIME(hdr.time);
		MPH_Trace_Ind(&hdr, chan->out_mbuf_cur->m_len, chan->out_mbuf_cur->m_data);
	}			

	len = 0;	/* # of chars put into HSCX tx fifo this time */

	/*
	 * fill the HSCX tx fifo with data from the current mbuf. if
	 * current mbuf holds less data than HSCX fifo length, try to
	 * get the next mbuf from (a possible) mbuf chain. if there is
	 * not enough data in a single mbuf or in a chain, then this
	 * is the last mbuf and we tell the HSCX that it has to send
	 * CRC and closing flag
	 */
	 
	while((len < sc->sc_bfifolen) && chan->out_mbuf_cur)
	{
		/*
		 * put as much data into the HSCX fifo as is
		 * available from the current mbuf
		 */
		 
		if((len + chan->out_mbuf_cur_len) >= sc->sc_bfifolen)
			next_len = sc->sc_bfifolen - len;
		else
			next_len = chan->out_mbuf_cur_len;

#ifdef NOTDEF		
		printf("b:mh=%x, mc=%x, mcp=%x, mcl=%d l=%d nl=%d # ",
			chan->out_mbuf_head,
			chan->out_mbuf_cur,			
			chan->out_mbuf_cur_ptr,
			chan->out_mbuf_cur_len,
			len,
			next_len);
#endif

		/* wait for tx fifo write enabled */

		isic_hscx_waitxfw(sc, h_chan);

		/* write what we have from current mbuf to HSCX fifo */

		HSCX_WRFIFO(h_chan, chan->out_mbuf_cur_ptr, next_len);

		len += next_len;		/* update # of bytes written */
		chan->txcount += next_len;	/* statistics */
		chan->out_mbuf_cur_ptr += next_len;	/* data ptr */
		chan->out_mbuf_cur_len -= next_len;	/* data len */

		/*
		 * in case the current mbuf (of a possible chain) data
		 * has been put into the fifo, check if there is a next
		 * mbuf in the chain. If there is one, get ptr to it
		 * and update the data ptr and the length
		 */
		 
		if((chan->out_mbuf_cur_len <= 0)	&&
		  ((chan->out_mbuf_cur = chan->out_mbuf_cur->m_next) != NULL))
		{
			chan->out_mbuf_cur_ptr = chan->out_mbuf_cur->m_data;
			chan->out_mbuf_cur_len = chan->out_mbuf_cur->m_len;

			if(sc->sc_trace & TRACE_B_TX)
			{
				i4b_trace_hdr_t hdr;
				hdr.unit = unit;
				hdr.type = (h_chan == HSCX_CH_A ? TRC_CH_B1 : TRC_CH_B2);
				hdr.dir = FROM_TE;
				hdr.count = ++sc->sc_trace_bcount;
				MICROTIME(hdr.time);
				MPH_Trace_Ind(&hdr, chan->out_mbuf_cur->m_len, chan->out_mbuf_cur->m_data);
			}			
		}
	}

	/*
	 * if there is either still data in the current mbuf and/or
	 * there is a successor on the chain available issue just
	 * a XTF (transmit) command to HSCX. if ther is no more
	 * data available from the current mbuf (-chain), issue
	 * an XTF and an XME (message end) command which will then
	 * send the CRC and the closing HDLC flag sequence
	 */
	 
	if(chan->out_mbuf_cur && (chan->out_mbuf_cur_len > 0))
	{
		/*
		 * more data available, send current fifo out.
		 * next xfer to HSCX tx fifo is done in the
		 * HSCX interrupt routine.
		 */
		 
		cmd |= HSCX_CMDR_XTF;
	}
	else
	{
		/* end of mbuf chain */
	
		if(chan->bprot == BPROT_NONE)
			cmd |= HSCX_CMDR_XTF;
		else
			cmd |= HSCX_CMDR_XTF | HSCX_CMDR_XME;
		
		i4b_Bfreembuf(chan->out_mbuf_head);	/* free mbuf chain */
		
		chan->out_mbuf_head = NULL;
		chan->out_mbuf_cur = NULL;			
		chan->out_mbuf_cur_ptr = NULL;
		chan->out_mbuf_cur_len = 0;
	}

	/* call timeout handling routine */
	
	if(activity == ACT_RX || activity == ACT_TX)
		(*chan->drvr_linktab->bch_activity)(chan->drvr_linktab->unit, activity);

	if(cmd)
		isic_hscx_cmd(sc, h_chan, cmd);
		
	splx(s);	
}

/*---------------------------------------------------------------------------*
 *	fill statistics struct
 *---------------------------------------------------------------------------*/
static void
isic_bchannel_stat(int unit, int h_chan, bchan_statistics_t *bsp)
{
#ifdef __FreeBSD__
	struct isic_softc *sc = &isic_sc[unit];
#else
	struct isic_softc *sc = isic_find_sc(unit);
#endif
	isic_Bchan_t *chan = &sc->sc_chan[h_chan];
	int s;

	s = SPLI4B();
	
	bsp->outbytes = chan->txcount;
	bsp->inbytes = chan->rxcount;

	chan->txcount = 0;
	chan->rxcount = 0;

	splx(s);
}

/*---------------------------------------------------------------------------*
 *	return the address of isic drivers linktab	
 *---------------------------------------------------------------------------*/
static isdn_link_t *
isic_ret_linktab(int unit, int channel)
{
#ifdef __FreeBSD__
	struct isic_softc *sc = &isic_sc[unit];
#else
	struct isic_softc *sc = isic_find_sc(unit);
#endif
	isic_Bchan_t *chan = &sc->sc_chan[channel];

	return(&chan->isdn_linktab);
}
 
/*---------------------------------------------------------------------------*
 *	set the driver linktab in the b channel softc
 *---------------------------------------------------------------------------*/
static void
isic_set_linktab(int unit, int channel, drvr_link_t *dlt)
{
#ifdef __FreeBSD__
	struct isic_softc *sc = &isic_sc[unit];
#else
	struct isic_softc *sc = isic_find_sc(unit);
#endif
	isic_Bchan_t *chan = &sc->sc_chan[channel];

	chan->drvr_linktab = dlt;
}

/*---------------------------------------------------------------------------*
 *	initialize our local linktab
 *---------------------------------------------------------------------------*/
void
isic_init_linktab(struct isic_softc *sc)
{
	isic_Bchan_t *chan = &sc->sc_chan[HSCX_CH_A];
	isdn_link_t *lt = &chan->isdn_linktab;

	/* make sure the hardware driver is known to layer 4 */
	ctrl_types[CTRL_PASSIVE].set_linktab = isic_set_linktab;
	ctrl_types[CTRL_PASSIVE].get_linktab = isic_ret_linktab;

	/* local setup */
	lt->unit = sc->sc_unit;
	lt->channel = HSCX_CH_A;
	lt->bch_config = isic_bchannel_setup;
	lt->bch_tx_start = isic_bchannel_start;
	lt->bch_stat = isic_bchannel_stat;
	lt->tx_queue = &chan->tx_queue;

	/* used by non-HDLC data transfers, i.e. telephony drivers */
	lt->rx_queue = &chan->rx_queue;

	/* used by HDLC data transfers, i.e. ipr and isp drivers */	
	lt->rx_mbuf = &chan->in_mbuf;	
                                                
	chan = &sc->sc_chan[HSCX_CH_B];
	lt = &chan->isdn_linktab;

	lt->unit = sc->sc_unit;
	lt->channel = HSCX_CH_B;
	lt->bch_config = isic_bchannel_setup;
	lt->bch_tx_start = isic_bchannel_start;
	lt->bch_stat = isic_bchannel_stat;
	lt->tx_queue = &chan->tx_queue;

	/* used by non-HDLC data transfers, i.e. telephony drivers */
	lt->rx_queue = &chan->rx_queue;

	/* used by HDLC data transfers, i.e. ipr and isp drivers */	
	lt->rx_mbuf = &chan->in_mbuf;	
}

/*---------------------------------------------------------------------------*
 *	telephony silence detection
 *---------------------------------------------------------------------------*/

#define TEL_IDLE_MIN (BCH_MAX_DATALEN/2)

int
isic_hscx_silence(unsigned char *data, int len)
{
	register int i = 0;
	register int j = 0;

	/* count idle bytes */
	
	for(;i < len; i++)
	{
		if((*data >= 0xaa) && (*data <= 0xac))
			j++;
		data++;
	}

#ifdef NOTDEF
	printf("isic_hscx_silence: got %d silence bytes in frame\n", j);
#endif
	
	if(j < (TEL_IDLE_MIN))
		return(0);
	else
		return(1);

}
 
#endif /* NISIC > 0 */
