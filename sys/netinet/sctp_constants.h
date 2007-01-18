/*-
 * Copyright (c) 2001-2007, Cisco Systems, Inc. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * a) Redistributions of source code must retain the above copyright notice,
 *   this list of conditions and the following disclaimer.
 *
 * b) Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *   the documentation and/or other materials provided with the distribution.
 *
 * c) Neither the name of Cisco Systems, Inc. nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
 * THE POSSIBILITY OF SUCH DAMAGE.
 */

/* $KAME: sctp_constants.h,v 1.17 2005/03/06 16:04:17 itojun Exp $	 */

#include <sys/cdefs.h>
__FBSDID("$FreeBSD$");

#ifndef __sctp_constants_h__
#define __sctp_constants_h__

#if defined(_KERNEL)
#include <sys/kernel.h>
#endif


#define SCTP_VERSION_STRING "KAME-BSD 1.1"
/* #define SCTP_AUDITING_ENABLED 1 used for debug/auditing */
#define SCTP_AUDIT_SIZE 256
#define SCTP_STAT_LOG_SIZE 80000

/* Places that CWND log can happen from */
#define SCTP_CWND_LOG_FROM_FR	1
#define SCTP_CWND_LOG_FROM_RTX	2
#define SCTP_CWND_LOG_FROM_BRST	3
#define SCTP_CWND_LOG_FROM_SS	4
#define SCTP_CWND_LOG_FROM_CA	5
#define SCTP_CWND_LOG_FROM_SAT	6
#define SCTP_BLOCK_LOG_INTO_BLK 7
#define SCTP_BLOCK_LOG_OUTOF_BLK 8
#define SCTP_BLOCK_LOG_CHECK     9
#define SCTP_STR_LOG_FROM_INTO_STRD 10
#define SCTP_STR_LOG_FROM_IMMED_DEL 11
#define SCTP_STR_LOG_FROM_INSERT_HD 12
#define SCTP_STR_LOG_FROM_INSERT_MD 13
#define SCTP_STR_LOG_FROM_INSERT_TL 14
#define SCTP_STR_LOG_FROM_MARK_TSN  15
#define SCTP_STR_LOG_FROM_EXPRS_DEL 16
#define SCTP_FR_LOG_BIGGEST_TSNS    17
#define SCTP_FR_LOG_STRIKE_TEST     18
#define SCTP_FR_LOG_STRIKE_CHUNK    19
#define SCTP_FR_T3_TIMEOUT          20
#define SCTP_MAP_PREPARE_SLIDE      21
#define SCTP_MAP_SLIDE_FROM         22
#define SCTP_MAP_SLIDE_RESULT       23
#define SCTP_MAP_SLIDE_CLEARED	    24
#define SCTP_MAP_SLIDE_NONE         25
#define SCTP_FR_T3_MARK_TIME        26
#define SCTP_FR_T3_MARKED           27
#define SCTP_FR_T3_STOPPED          28
#define SCTP_FR_MARKED              30
#define SCTP_CWND_LOG_NOADV_SS      31
#define SCTP_CWND_LOG_NOADV_CA      32
#define SCTP_MAX_BURST_APPLIED      33
#define SCTP_MAX_IFP_APPLIED        34
#define SCTP_MAX_BURST_ERROR_STOP   35
#define SCTP_INCREASE_PEER_RWND     36
#define SCTP_DECREASE_PEER_RWND     37
#define SCTP_SET_PEER_RWND_VIA_SACK 38
#define SCTP_LOG_MBCNT_INCREASE     39
#define SCTP_LOG_MBCNT_DECREASE     40
#define SCTP_LOG_MBCNT_CHKSET       41
#define SCTP_LOG_NEW_SACK           42
#define SCTP_LOG_TSN_ACKED          43
#define SCTP_LOG_TSN_REVOKED        44
#define SCTP_LOG_LOCK_TCB           45
#define SCTP_LOG_LOCK_INP           46
#define SCTP_LOG_LOCK_SOCK          47
#define SCTP_LOG_LOCK_SOCKBUF_R     48
#define SCTP_LOG_LOCK_SOCKBUF_S     49
#define SCTP_LOG_LOCK_CREATE        50
#define SCTP_LOG_INITIAL_RTT        51
#define SCTP_LOG_RTTVAR             52
#define SCTP_LOG_SBALLOC            53
#define SCTP_LOG_SBFREE             54
#define SCTP_LOG_SBRESULT           55
#define SCTP_FR_DUPED               56
#define SCTP_FR_MARKED_EARLY        57
#define SCTP_FR_CWND_REPORT         58
#define SCTP_FR_CWND_REPORT_START   59
#define SCTP_FR_CWND_REPORT_STOP    60
#define SCTP_CWND_LOG_FROM_SEND     61
#define SCTP_CWND_INITIALIZATION    62
#define SCTP_CWND_LOG_FROM_T3       63
#define SCTP_CWND_LOG_FROM_SACK     64
#define SCTP_CWND_LOG_NO_CUMACK     65
#define SCTP_CWND_LOG_FROM_RESEND   66
#define SCTP_FR_LOG_CHECK_STRIKE    67
#define SCTP_SEND_NOW_COMPLETES     68
#define SCTP_CWND_LOG_FILL_OUTQ_CALLED 69
#define SCTP_CWND_LOG_FILL_OUTQ_FILLS  70
#define SCTP_LOG_FREE_SENT             71
#define SCTP_NAGLE_APPLIED          72
#define SCTP_NAGLE_SKIPPED          73
#define SCTP_WAKESND_FROM_SACK      74
#define SCTP_WAKESND_FROM_FWDTSN    75
#define SCTP_NOWAKE_FROM_SACK       76
#define SCTP_CWNDLOG_PRESEND        77
#define SCTP_CWNDLOG_ENDSEND        78
#define SCTP_AT_END_OF_SACK         79
#define SCTP_REASON_FOR_SC          80
#define SCTP_BLOCK_LOG_INTO_BLKA    81
#define SCTP_ENTER_USER_RECV        82
#define SCTP_USER_RECV_SACKS        83
#define SCTP_SORECV_BLOCKSA         84
#define SCTP_SORECV_BLOCKSB         85
#define SCTP_SORECV_DONE            86
#define SCTP_SACK_RWND_UPDATE       87
#define SCTP_SORECV_ENTER           88
#define SCTP_SORECV_ENTERPL         89
#define SCTP_MBUF_INPUT             90
#define SCTP_MBUF_IALLOC            91
#define SCTP_MBUF_IFREE             92
#define SCTP_MBUF_ICOPY             93
#define SCTP_SORCV_FREECTL          94
#define SCTP_SORCV_DOESCPY          95
#define SCTP_SORCV_DOESLCK          96
#define SCTP_SORCV_DOESADJ          97
#define SCTP_SORCV_BOTWHILE         98
#define SCTP_SORCV_PASSBF           99
#define SCTP_SORCV_ADJD            100
#define SCTP_UNKNOWN_MAX           101
#define SCTP_RANDY_STUFF           102
#define SCTP_RANDY_STUFF1          103
#define SCTP_STRMOUT_LOG_ASSIGN	   104
#define SCTP_STRMOUT_LOG_SEND	   105
#define SCTP_FLIGHT_LOG_DOWN       106
#define SCTP_FLIGHT_LOG_UP         107
#define SCTP_LOG_MAX_TYPES 108
/*
 * To turn on various logging, you must first define SCTP_STAT_LOGGING. Then
 * to get something to log you define one of the logging defines i.e.
 *
 * SCTP_CWND_LOGGING SCTP_BLK_LOGGING SCTP_STR_LOGGING SCTP_FR_LOGGING
 *
 * Any one or a combination of the logging can be turned on.
 */
#define SCTP_LOG_EVENT_UNKNOWN 0
#define SCTP_LOG_EVENT_CWND  1
#define SCTP_LOG_EVENT_BLOCK 2
#define SCTP_LOG_EVENT_STRM  3
#define SCTP_LOG_EVENT_FR    4
#define SCTP_LOG_EVENT_MAP   5
#define SCTP_LOG_EVENT_MAXBURST 6
#define SCTP_LOG_EVENT_RWND  7
#define SCTP_LOG_EVENT_MBCNT 8
#define SCTP_LOG_EVENT_SACK  9
#define SCTP_LOG_LOCK_EVENT 10
#define SCTP_LOG_EVENT_RTT  11
#define SCTP_LOG_EVENT_SB   12
#define SCTP_LOG_EVENT_NAGLE 13
#define SCTP_LOG_EVENT_WAKE 14
#define SCTP_LOG_MISC_EVENT 15
#define SCTP_LOG_EVENT_CLOSE 16
#define SCTP_LOG_EVENT_MBUF 17

#define SCTP_LOG_MAX_EVENT 18

#define SCTP_LOCK_UNKNOWN 2


/* number of associations by default for zone allocation */
#define SCTP_MAX_NUM_OF_ASOC	40000
/* how many addresses per assoc remote and local */
#define SCTP_SCALE_FOR_ADDR	2

/* default AUTO_ASCONF mode enable(1)/disable(0) value (sysctl) */
#define SCTP_DEFAULT_AUTO_ASCONF	0

/*
 * Theshold for rwnd updates, we have to read (sb_hiwat >>
 * SCTP_RWND_HIWAT_SHIFT) before we will look to see if we need to send a
 * window update sack. When we look, we compare the last rwnd we sent vs the
 * current rwnd. It too must be greater than this value. Using 3 divdes the
 * hiwat by 8, so for 200k rwnd we need to read 24k. For a 64k rwnd we need
 * to read 8k. This seems about right.. I hope :-D.. we do set a
 * min of a MTU on it so if the rwnd is real small we will insist
 * on a full MTU of 1500 bytes.
 */
#define SCTP_RWND_HIWAT_SHIFT 3

/* How much of the rwnd must the
 * message be taking up to start partial delivery.
 * We calculate this by shifing the hi_water (recv_win)
 * left the following .. set to 1, when a message holds
 * 1/2 the rwnd. If we set it to 2 when a message holds
 * 1/4 the rwnd...etc..
 */

#define SCTP_PARTIAL_DELIVERY_SHIFT 1

/* Minimum number of bytes read by user before we
 * condsider doing a rwnd update
 */
#define SCTP_MIN_READ_BEFORE_CONSIDERING  3000

/*
 * default HMAC for cookies, etc... use one of the AUTH HMAC id's
 * SCTP_HMAC is the HMAC_ID to use
 * SCTP_SIGNATURE_SIZE is the digest length
 */
#define SCTP_HMAC		SCTP_AUTH_HMAC_ID_SHA1
#define SCTP_SIGNATURE_SIZE	SCTP_AUTH_DIGEST_LEN_SHA1
#define SCTP_SIGNATURE_ALOC_SIZE SCTP_SIGNATURE_SIZE

/* DEFINE HERE WHAT CRC YOU WANT TO USE */
#define SCTP_USECRC_RFC2960  1
/* #define SCTP_USECRC_FLETCHER 1 */
/* #define SCTP_USECRC_SSHCRC32 1 */
/* #define SCTP_USECRC_FASTCRC32 1 */
/* #define SCTP_USECRC_CRC32 1 */
/* #define SCTP_USECRC_TCP32 1 */
/* #define SCTP_USECRC_CRC16SMAL 1 */
/* #define SCTP_USECRC_CRC16 1 */
/* #define SCTP_USECRC_MODADLER 1 */

#ifndef SCTP_ADLER32_BASE
#define SCTP_ADLER32_BASE 65521
#endif

/*
 * the SCTP protocol signature this includes the version number encoded in
 * the last 4 bits of the signature.
 */
#define PROTO_SIGNATURE_A	0x30000000
#define SCTP_VERSION_NUMBER	0x3

#define MAX_TSN	0xffffffff
#define MAX_SEQ	0xffff

/* how many executions every N tick's */
#define SCTP_ITERATOR_MAX_AT_ONCE 20

/* number of clock ticks between iterator executions */
#define SCTP_ITERATOR_TICKS 1

/*
 * option: If you comment out the following you will receive the old behavior
 * of obeying cwnd for the fast retransmit algorithm. With this defined a FR
 * happens right away with-out waiting for the flightsize to drop below the
 * cwnd value (which is reduced by the FR to 1/2 the inflight packets).
 */
#define SCTP_IGNORE_CWND_ON_FR 1

/*
 * Adds implementors guide behavior to only use newest highest update in SACK
 * gap ack's to figure out if you need to stroke a chunk for FR.
 */
#define SCTP_NO_FR_UNLESS_SEGMENT_SMALLER 1

/* default max I can burst out after a fast retransmit */
#define SCTP_DEF_MAX_BURST 4
/* IP hdr (20/40) + 12+2+2 (enet) + sctp common 12 */
#define SCTP_FIRST_MBUF_RESV 68
/* Packet transmit states in the sent field */
#define SCTP_DATAGRAM_UNSENT		0
#define SCTP_DATAGRAM_SENT		1
#define SCTP_DATAGRAM_RESEND1		2	/* not used (in code, but may
						 * hit this value) */
#define SCTP_DATAGRAM_RESEND2		3	/* not used (in code, but may
						 * hit this value) */
#define SCTP_DATAGRAM_RESEND		4
#define SCTP_DATAGRAM_ACKED		10010
#define SCTP_DATAGRAM_INBOUND		10011
#define SCTP_READY_TO_TRANSMIT		10012
#define SCTP_DATAGRAM_MARKED		20010
#define SCTP_FORWARD_TSN_SKIP		30010

/* chunk output send from locations */
#define SCTP_OUTPUT_FROM_USR_SEND       0
#define SCTP_OUTPUT_FROM_T3       	1
#define SCTP_OUTPUT_FROM_INPUT_ERROR    2
#define SCTP_OUTPUT_FROM_CONTROL_PROC   3
#define SCTP_OUTPUT_FROM_SACK_TMR       4
#define SCTP_OUTPUT_FROM_SHUT_TMR       5
#define SCTP_OUTPUT_FROM_HB_TMR         6
#define SCTP_OUTPUT_FROM_SHUT_ACK_TMR   7
#define SCTP_OUTPUT_FROM_ASCONF_TMR     8
#define SCTP_OUTPUT_FROM_STRRST_TMR     9
#define SCTP_OUTPUT_FROM_AUTOCLOSE_TMR  10
#define SCTP_OUTPUT_FROM_EARLY_FR_TMR   11
#define SCTP_OUTPUT_FROM_STRRST_REQ     12
#define SCTP_OUTPUT_FROM_USR_RCVD       13
#define SCTP_OUTPUT_FROM_COOKIE_ACK     14
/* SCTP chunk types are moved sctp.h for application (NAT, FW) use */

/* align to 32-bit sizes */
#define SCTP_SIZE32(x)	((((x)+3) >> 2) << 2)

#define IS_SCTP_CONTROL(a) ((a)->chunk_type != SCTP_DATA)
#define IS_SCTP_DATA(a) ((a)->chunk_type == SCTP_DATA)


/* SCTP parameter types */
/*************0x0000 series*************/
#define SCTP_HEARTBEAT_INFO		0x0001
#define SCTP_IPV4_ADDRESS		0x0005
#define SCTP_IPV6_ADDRESS		0x0006
#define SCTP_STATE_COOKIE		0x0007
#define SCTP_UNRECOG_PARAM		0x0008
#define SCTP_COOKIE_PRESERVE		0x0009
#define SCTP_HOSTNAME_ADDRESS		0x000b
#define SCTP_SUPPORTED_ADDRTYPE		0x000c

/* draft-ietf-stewart-strreset-xxx */
#define SCTP_STR_RESET_OUT_REQUEST	0x000d
#define SCTP_STR_RESET_IN_REQUEST	0x000e
#define SCTP_STR_RESET_TSN_REQUEST	0x000f
#define SCTP_STR_RESET_RESPONSE		0x0010

#define SCTP_MAX_RESET_PARAMS 2
#define SCTP_STREAM_RESET_TSN_DELTA    0x1000

/*************0x4000 series*************/

/*************0x8000 series*************/
#define SCTP_ECN_CAPABLE		0x8000
/* ECN Nonce: draft-ladha-sctp-ecn-nonce */
#define SCTP_ECN_NONCE_SUPPORTED	0x8001
/* draft-ietf-tsvwg-auth-xxx */
#define SCTP_RANDOM			0x8002
#define SCTP_CHUNK_LIST			0x8003
#define SCTP_HMAC_LIST			0x8004
/*
 * draft-ietf-tsvwg-addip-sctp-xx param=0x8008  len=0xNNNN Byte | Byte | Byte
 * | Byte Byte | Byte ...
 *
 * Where each byte is a chunk type extension supported. For example, to support
 * all chunks one would have (in hex):
 *
 * 80 01 00 09 C0 C1 80 81 82 00 00 00
 *
 * Has the parameter. C0 = PR-SCTP    (RFC3758) C1, 80 = ASCONF (addip draft) 81
 * = Packet Drop 82 = Stream Reset 83 = Authentication
 */
#define SCTP_SUPPORTED_CHUNK_EXT    0x8008

/*************0xC000 series*************/
#define SCTP_PRSCTP_SUPPORTED		0xc000
/* draft-ietf-tsvwg-addip-sctp */
#define SCTP_ADD_IP_ADDRESS		0xc001
#define SCTP_DEL_IP_ADDRESS		0xc002
#define SCTP_ERROR_CAUSE_IND		0xc003
#define SCTP_SET_PRIM_ADDR		0xc004
#define SCTP_SUCCESS_REPORT		0xc005
#define SCTP_ULP_ADAPTATION		0xc006

/* Notification error codes */
#define SCTP_NOTIFY_DATAGRAM_UNSENT	0x0001
#define SCTP_NOTIFY_DATAGRAM_SENT	0x0002
#define SCTP_FAILED_THRESHOLD		0x0004
#define SCTP_HEARTBEAT_SUCCESS		0x0008
#define SCTP_RESPONSE_TO_USER_REQ	0x000f
#define SCTP_INTERNAL_ERROR		0x0010
#define SCTP_SHUTDOWN_GUARD_EXPIRES	0x0020
#define SCTP_RECEIVED_SACK		0x0040
#define SCTP_PEER_FAULTY		0x0080

/* bits for TOS field */
#define SCTP_ECT0_BIT		0x02
#define SCTP_ECT1_BIT		0x01
#define SCTP_CE_BITS		0x03

/* below turns off above */
#define SCTP_FLEXIBLE_ADDRESS	0x20
#define SCTP_NO_HEARTBEAT	0x40

/* mask to get sticky */
#define SCTP_STICKY_OPTIONS_MASK	0x0c


/* Chunk flags */
#define SCTP_WINDOW_PROBE	0x01

/*
 * SCTP states for internal state machine XXX (should match "user" values)
 */
#define SCTP_STATE_EMPTY		0x0000
#define SCTP_STATE_INUSE		0x0001
#define SCTP_STATE_COOKIE_WAIT		0x0002
#define SCTP_STATE_COOKIE_ECHOED	0x0004
#define SCTP_STATE_OPEN			0x0008
#define SCTP_STATE_SHUTDOWN_SENT	0x0010
#define SCTP_STATE_SHUTDOWN_RECEIVED	0x0020
#define SCTP_STATE_SHUTDOWN_ACK_SENT	0x0040
#define SCTP_STATE_SHUTDOWN_PENDING	0x0080
#define SCTP_STATE_CLOSED_SOCKET	0x0100
#define SCTP_STATE_ABOUT_TO_BE_FREED    0x0200
#define SCTP_STATE_PARTIAL_MSG_LEFT     0x0400
#define SCTP_STATE_MASK			0x007f

#define SCTP_GET_STATE(asoc)	((asoc)->state & SCTP_STATE_MASK)

/* SCTP reachability state for each address */
#define SCTP_ADDR_REACHABLE		0x001
#define SCTP_ADDR_NOT_REACHABLE		0x002
#define SCTP_ADDR_NOHB			0x004
#define SCTP_ADDR_BEING_DELETED		0x008
#define SCTP_ADDR_NOT_IN_ASSOC		0x010
#define SCTP_ADDR_WAS_PRIMARY		0x020
#define SCTP_ADDR_SWITCH_PRIMARY	0x040
#define SCTP_ADDR_OUT_OF_SCOPE		0x080
#define SCTP_ADDR_DOUBLE_SWITCH		0x100
#define SCTP_ADDR_UNCONFIRMED		0x200

#define SCTP_REACHABLE_MASK		0x203

/* bound address types (e.g. valid address types to allow) */
#define SCTP_BOUND_V6		0x01
#define SCTP_BOUND_V4		0x02

/*
 * what is the default number of mbufs in a chain I allow before switching to
 * a cluster
 */
#define SCTP_DEFAULT_MBUFS_IN_CHAIN 5

/* How long a cookie lives in seconds */
#define SCTP_DEFAULT_COOKIE_LIFE	60

/* resource limit of streams */
#define MAX_SCTP_STREAMS	2048

/* Maximum the mapping array will  grow to (TSN mapping array) */
#define SCTP_MAPPING_ARRAY	512

/* size of the inital malloc on the mapping array */
#define SCTP_INITIAL_MAPPING_ARRAY  16
/* how much we grow the mapping array each call */
#define SCTP_MAPPING_ARRAY_INCR     32

/*
 * Here we define the timer types used by the implementation as arguments in
 * the set/get timer type calls.
 */
#define SCTP_TIMER_INIT 	0
#define SCTP_TIMER_RECV 	1
#define SCTP_TIMER_SEND 	2
#define SCTP_TIMER_HEARTBEAT	3
#define SCTP_TIMER_PMTU		4
#define SCTP_TIMER_MAXSHUTDOWN	5
#define SCTP_TIMER_SIGNATURE	6
/*
 * number of timer types in the base SCTP structure used in the set/get and
 * has the base default.
 */
#define SCTP_NUM_TMRS	7

/* timer types */
#define SCTP_TIMER_TYPE_NONE		0
#define SCTP_TIMER_TYPE_SEND		1
#define SCTP_TIMER_TYPE_INIT		2
#define SCTP_TIMER_TYPE_RECV		3
#define SCTP_TIMER_TYPE_SHUTDOWN	4
#define SCTP_TIMER_TYPE_HEARTBEAT	5
#define SCTP_TIMER_TYPE_COOKIE		6
#define SCTP_TIMER_TYPE_NEWCOOKIE	7
#define SCTP_TIMER_TYPE_PATHMTURAISE	8
#define SCTP_TIMER_TYPE_SHUTDOWNACK	9
#define SCTP_TIMER_TYPE_ASCONF		10
#define SCTP_TIMER_TYPE_SHUTDOWNGUARD	11
#define SCTP_TIMER_TYPE_AUTOCLOSE	12
#define SCTP_TIMER_TYPE_EVENTWAKE	13
#define SCTP_TIMER_TYPE_STRRESET        14
#define SCTP_TIMER_TYPE_INPKILL         15
#define SCTP_TIMER_TYPE_ITERATOR        16
#define SCTP_TIMER_TYPE_EARLYFR         17
#define SCTP_TIMER_TYPE_ASOCKILL        18
#define SCTP_TIMER_TYPE_ADDR_WQ         19
/* add new timers here - and increment LAST */
#define SCTP_TIMER_TYPE_LAST            20

#define SCTP_IS_TIMER_TYPE_VALID(t)	(((t) > SCTP_TIMER_TYPE_NONE) && \
					 ((t) < SCTP_TIMER_TYPE_LAST))



/*
 * Number of ticks before the soxwakeup() event that is delayed is sent AFTER
 * the accept() call
 */
#define SCTP_EVENTWAKEUP_WAIT_TICKS	3000

/*
 * Of course we really don't collect stale cookies, being folks of decerning
 * taste. However we do count them, if we get too many before the association
 * comes up.. we give up. Below is the constant that dictates when we give it
 * up...this is a implemenation dependent treatment. In ours we do not ask
 * for a extension of time, but just retry this many times...
 */
#define SCTP_MAX_STALE_COOKIES_I_COLLECT 10

/* max number of TSN's dup'd that I will hold */
#define SCTP_MAX_DUP_TSNS	20

/*
 * Here we define the types used when setting the retry amounts.
 */
/* constants for type of set */
#define SCTP_MAXATTEMPT_INIT	2
#define SCTP_MAXATTEMPT_SEND	3

/* Maximum TSN's we will summarize in a drop report */
#define SCTP_MAX_DROP_REPORT 16

/* How many drop re-attempts we make on  INIT/COOKIE-ECHO */
#define SCTP_RETRY_DROPPED_THRESH 4

/*
 * And the max we will keep a history of in the tcb which MUST be lower than
 * 256.
 */
#define SCTP_MAX_DROP_SAVE_REPORT 16

/*
 * Here we define the default timers and the default number of attemts we
 * make for each respective side (send/init).
 */

/*
 * Maxmium number of chunks a single association can have on it. Note that
 * this is a squishy number since the count can run over this if the user
 * sends a large message down .. the fragmented chunks don't count until
 * AFTER the message is on queue.. it would be the next send that blocks
 * things. This number will get tuned up at boot in the sctp_init and use the
 * number of clusters as a base. This way high bandwidth environments will
 * not get impacted by the lower bandwidth sending a bunch of 1 byte chunks
 */
#define SCTP_ASOC_MAX_CHUNKS_ON_QUEUE 512

#define MSEC_TO_TICKS(x) ((hz == 1000) ? x : (((x) * hz) / 1000))
#define TICKS_TO_MSEC(x) ((hz == 1000) ? x : (((x) * 1000) / hz));

#define SEC_TO_TICKS(x) ((x) * hz)
#define TICKS_TO_SEC(x) ((x) / hz)

/*
 * Basically the minimum amount of time before I do a early FR. Making this
 * value to low will cause duplicate retransmissions.
 */
#define SCTP_MINFR_MSEC_TIMER 250
/* The floor this value is allowed to fall to when starting a timer. */
#define SCTP_MINFR_MSEC_FLOOR 20

/* init timer def = 1 sec */
#define SCTP_INIT_SEC	1

/* send timer def = 1 seconds */
#define SCTP_SEND_SEC	1

/* recv timer def = 200ms  */
#define SCTP_RECV_MSEC	200

/* 30 seconds + RTO (in ms) */
#define SCTP_HB_DEFAULT_MSEC	30000

/* Max time I will wait for Shutdown to complete */
#define SCTP_DEF_MAX_SHUTDOWN_SEC 180


/*
 * This is how long a secret lives, NOT how long a cookie lives how many
 * ticks the current secret will live.
 */
#define SCTP_DEFAULT_SECRET_LIFE_SEC 3600

#define SCTP_RTO_UPPER_BOUND	(60000)	/* 60 sec in ms */
#define SCTP_RTO_UPPER_BOUND_SEC 60	/* for the init timer */
#define SCTP_RTO_LOWER_BOUND	(1000)	/* 1 sec in ms */
#define SCTP_RTO_INITIAL	(3000)	/* 3 sec in ms */


#define SCTP_INP_KILL_TIMEOUT 20/* number of ms to retry kill of inpcb */
#define SCTP_ASOC_KILL_TIMEOUT 10	/* number of ms to retry kill of inpcb */

#define SCTP_DEF_MAX_INIT	8
#define SCTP_DEF_MAX_SEND	10
#define SCTP_DEF_MAX_PATH_RTX	4

#define SCTP_DEF_PMTU_RAISE_SEC	600	/* 10 min between raise attempts */
#define SCTP_DEF_PMTU_MIN	600

#define SCTP_MSEC_IN_A_SEC	1000
#define SCTP_USEC_IN_A_SEC	1000000
#define SCTP_NSEC_IN_A_SEC	1000000000

#define SCTP_MAX_OUTSTANDING_DG	10000

/* How many streams I request initally by default */
#define SCTP_OSTREAM_INITIAL 10

/*
 * How many smallest_mtu's need to increase before a window update sack is
 * sent (should be a power of 2).
 */
#define SCTP_SEG_TO_RWND_UPD 32
/* Send window update (incr * this > hiwat). Should be a power of 2 */
#define SCTP_SCALE_OF_RWND_TO_UPD       4
#define SCTP_MINIMAL_RWND		(4096)	/* minimal rwnd */

#define SCTP_ADDRMAX		20

/* SCTP DEBUG Switch parameters */
#define SCTP_DEBUG_TIMER1	0x00000001
#define SCTP_DEBUG_TIMER2	0x00000002
#define SCTP_DEBUG_TIMER3	0x00000004
#define SCTP_DEBUG_TIMER4	0x00000008
#define SCTP_DEBUG_OUTPUT1	0x00000010
#define SCTP_DEBUG_OUTPUT2	0x00000020
#define SCTP_DEBUG_OUTPUT3	0x00000040
#define SCTP_DEBUG_OUTPUT4	0x00000080
#define SCTP_DEBUG_UTIL1	0x00000100
#define SCTP_DEBUG_UTIL2	0x00000200
#define SCTP_DEBUG_AUTH1	0x00000400
#define SCTP_DEBUG_AUTH2	0x00000800
#define SCTP_DEBUG_INPUT1	0x00001000
#define SCTP_DEBUG_INPUT2	0x00002000
#define SCTP_DEBUG_INPUT3	0x00004000
#define SCTP_DEBUG_INPUT4	0x00008000
#define SCTP_DEBUG_ASCONF1	0x00010000
#define SCTP_DEBUG_ASCONF2	0x00020000
#define SCTP_DEBUG_OUTPUT5	0x00040000
#define SCTP_DEBUG_XXX		0x00080000
#define SCTP_DEBUG_PCB1		0x00100000
#define SCTP_DEBUG_PCB2		0x00200000
#define SCTP_DEBUG_PCB3		0x00400000
#define SCTP_DEBUG_PCB4		0x00800000
#define SCTP_DEBUG_INDATA1	0x01000000
#define SCTP_DEBUG_INDATA2	0x02000000
#define SCTP_DEBUG_INDATA3	0x04000000
#define SCTP_DEBUG_INDATA4	0x08000000
#define SCTP_DEBUG_USRREQ1	0x10000000
#define SCTP_DEBUG_USRREQ2	0x20000000
#define SCTP_DEBUG_PEEL1	0x40000000
#define SCTP_DEBUG_XXXXX	0x80000000
#define SCTP_DEBUG_ALL		0x7ff3ffff
#define SCTP_DEBUG_NOISY	0x00040000

/* What sender needs to see to avoid SWS or we consider peers rwnd 0 */
#define SCTP_SWS_SENDER_DEF	1420

/*
 * SWS is scaled to the sb_hiwat of the socket. A value of 2 is hiwat/4, 1
 * would be hiwat/2 etc.
 */
/* What receiver needs to see in sockbuf or we tell peer its 1 */
#define SCTP_SWS_RECEIVER_DEF	3000

#define SCTP_INITIAL_CWND 4380

/* amount peer is obligated to have in rwnd or I will abort */
#define SCTP_MIN_RWND	1500

#define SCTP_WINDOW_MIN	1500	/* smallest rwnd can be */
#define SCTP_WINDOW_MAX 1048576	/* biggest I can grow rwnd to My playing
				 * around suggests a value greater than 64k
				 * does not do much, I guess via the kernel
				 * limitations on the stream/socket. */

/* I can handle a 1meg re-assembly */
#define SCTP_DEFAULT_MAXMSGREASM 1048576

#define SCTP_DEFAULT_MAXSEGMENT 65535

#define DEFAULT_CHUNK_BUFFER	2048
#define DEFAULT_PARAM_BUFFER	512

#define SCTP_DEFAULT_MINSEGMENT 512	/* MTU size ... if no mtu disc */
#define SCTP_HOW_MANY_SECRETS	2	/* how many secrets I keep */

#define SCTP_NUMBER_OF_SECRETS	8	/* or 8 * 4 = 32 octets */
#define SCTP_SECRET_SIZE	32	/* number of octets in a 256 bits */


/*
 * SCTP upper layer notifications
 */
#define SCTP_NOTIFY_ASSOC_UP		1
#define SCTP_NOTIFY_ASSOC_DOWN		2
#define SCTP_NOTIFY_INTERFACE_DOWN	3
#define SCTP_NOTIFY_INTERFACE_UP	4
#define SCTP_NOTIFY_DG_FAIL		5
#define SCTP_NOTIFY_STRDATA_ERR 	6
#define SCTP_NOTIFY_ASSOC_ABORTED	7
#define SCTP_NOTIFY_PEER_OPENED_STREAM	8
#define SCTP_NOTIFY_STREAM_OPENED_OK	9
#define SCTP_NOTIFY_ASSOC_RESTART	10
#define SCTP_NOTIFY_HB_RESP             11
#define SCTP_NOTIFY_ASCONF_SUCCESS	12
#define SCTP_NOTIFY_ASCONF_FAILED	13
#define SCTP_NOTIFY_PEER_SHUTDOWN	14
#define SCTP_NOTIFY_ASCONF_ADD_IP	15
#define SCTP_NOTIFY_ASCONF_DELETE_IP	16
#define SCTP_NOTIFY_ASCONF_SET_PRIMARY	17
#define SCTP_NOTIFY_PARTIAL_DELVIERY_INDICATION 18
#define SCTP_NOTIFY_ADAPTATION_INDICATION       19
/* same as above */
#define SCTP_NOTIFY_ADAPTION_INDICATION         19
#define SCTP_NOTIFY_INTERFACE_CONFIRMED 20
#define SCTP_NOTIFY_STR_RESET_RECV      21
#define SCTP_NOTIFY_STR_RESET_SEND      22
#define SCTP_NOTIFY_STR_RESET_FAILED_OUT 23
#define SCTP_NOTIFY_STR_RESET_FAILED_IN 24
#define SCTP_NOTIFY_AUTH_NEW_KEY	25
#define SCTP_NOTIFY_AUTH_KEY_CONFLICT	26
#define SCTP_NOTIFY_SPECIAL_SP_FAIL     27
#define SCTP_NOTIFY_MAX			27

/* This is the value for messages that are NOT completely
 * copied down where we will start to split the message.
 * So, with our default, we split only if the piece we
 * want to take will fill up a full MTU (assuming
 * a 1500 byte MTU).
 */
#define SCTP_DEFAULT_SPLIT_POINT_MIN 1452

/* ABORT CODES and other tell-tale location
 * codes are generated by adding the below
 * to the instance id.
 */

/* File defines */
#define SCTP_FROM_SCTP_INPUT   0x10000000
#define SCTP_FROM_SCTP_PCB     0x20000000
#define SCTP_FROM_SCTP_INDATA  0x30000000
#define SCTP_FROM_SCTP_TIMER   0x40000000
#define SCTP_FROM_SCTP_USRREQ  0x50000000
#define SCTP_FROM_SCTPUTIL     0x60000000
#define SCTP_FROM_SCTP6_USRREQ 0x70000000
#define SCTP_FROM_SCTP_ASCONF  0x80000000
#define SCTP_FROM_SCTP_OUTPUT  0x90000000
#define SCTP_FROM_SCTP_PEELOFF 0xa0000000

/* Location ID's */
#define SCTP_LOC_1  0x00000001
#define SCTP_LOC_2  0x00000002
#define SCTP_LOC_3  0x00000003
#define SCTP_LOC_4  0x00000004
#define SCTP_LOC_5  0x00000005
#define SCTP_LOC_6  0x00000006
#define SCTP_LOC_7  0x00000007
#define SCTP_LOC_8  0x00000008
#define SCTP_LOC_9  0x00000009
#define SCTP_LOC_10 0x0000000a
#define SCTP_LOC_11 0x0000000b
#define SCTP_LOC_12 0x0000000c
#define SCTP_LOC_13 0x0000000d
#define SCTP_LOC_14 0x0000000e
#define SCTP_LOC_15 0x0000000f
#define SCTP_LOC_16 0x00000010
#define SCTP_LOC_17 0x00000011
#define SCTP_LOC_18 0x00000012
#define SCTP_LOC_19 0x00000013
#define SCTP_LOC_20 0x00000014
#define SCTP_LOC_21 0x00000015
#define SCTP_LOC_22 0x00000016
#define SCTP_LOC_23 0x00000017
#define SCTP_LOC_24 0x00000018
#define SCTP_LOC_25 0x00000019
#define SCTP_LOC_26 0x0000001a
#define SCTP_LOC_27 0x0000001b
#define SCTP_LOC_28 0x0000001c
#define SCTP_LOC_29 0x0000001d
#define SCTP_LOC_30 0x0000001e
#define SCTP_LOC_31 0x0000001f
#define SCTP_LOC_32 0x00000020


/* Free assoc codes */
#define SCTP_NORMAL_PROC      0
#define SCTP_PCBFREE_NOFORCE  1
#define SCTP_PCBFREE_FORCE    2

/* From codes for adding addresses */
#define SCTP_ADDR_IS_CONFIRMED 8
#define SCTP_ADDR_DYNAMIC_ADDED 6
#define SCTP_IN_COOKIE_PROC 100
#define SCTP_ALLOC_ASOC  1
#define SCTP_LOAD_ADDR_2 2
#define SCTP_LOAD_ADDR_3 3
#define SCTP_LOAD_ADDR_4 4
#define SCTP_LOAD_ADDR_5 5

#define SCTP_DONOT_SETSCOPE 0
#define SCTP_DO_SETSCOPE 1


/* This value determines the default for when
 * we try to add more on the send queue., if
 * there is room. This prevents us from cycling
 * into the copy_resume routine to often if
 * we have not got enough space to add a decent
 * enough size message. Note that if we have enough
 * space to complete the message copy we will always
 * add to the message, no matter what the size. Its
 * only when we reach the point that we have some left
 * to add, there is only room for part of it that we
 * will use this threshold. Its also a sysctl.
 */
#define SCTP_DEFAULT_ADD_MORE 1452

#ifndef SCTP_PCBHASHSIZE
/* default number of association hash buckets in each endpoint */
#define SCTP_PCBHASHSIZE 256
#endif
#ifndef SCTP_TCBHASHSIZE
#define SCTP_TCBHASHSIZE 1024
#endif

#ifndef SCTP_CHUNKQUEUE_SCALE
#define SCTP_CHUNKQUEUE_SCALE 10
#endif

/* clock variance is 1 ms */
#define SCTP_CLOCK_GRANULARITY	1
#define IP_HDR_SIZE 40		/* we use the size of a IP6 header here this
				 * detracts a small amount for ipv4 but it
				 * simplifies the ipv6 addition */

#ifndef IPPROTO_SCTP
#define IPPROTO_SCTP 132	/* the Official IANA number :-) */
#endif				/* !IPPROTO_SCTP */

#define SCTP_MAX_DATA_BUNDLING		256
#define SCTP_MAX_CONTROL_BUNDLING	20

/* modular comparison */
/* True if a > b (mod = M) */
#define compare_with_wrap(a, b, M) (((a > b) && ((a - b) < ((M >> 1) + 1))) || \
              ((b > a) && ((b - a) > ((M >> 1) + 1))))


/* Mapping array manipulation routines */
#define SCTP_IS_TSN_PRESENT(arry, gap) ((arry[(gap >> 3)] >> (gap & 0x07)) & 0x01)
#define SCTP_SET_TSN_PRESENT(arry, gap) (arry[(gap >> 3)] |= (0x01 << ((gap & 0x07))))
#define SCTP_UNSET_TSN_PRESENT(arry, gap) (arry[(gap >> 3)] &= ((~(0x01 << ((gap & 0x07)))) & 0xff))


/*
 * This value defines the number of vtag block time wait entry's per list
 * element.  Each entry will take 2 4 byte ints (and of course the overhead
 * of the next pointer as well). Using 15 as an example will yield * ((8 *
 * 15) + 8) or 128 bytes of overhead for each timewait block that gets
 * initialized. Increasing it to 31 would yeild 256 bytes per block.
 */
#define SCTP_NUMBER_IN_VTAG_BLOCK 15
/*
 * If we use the STACK option, we have an array of this size head pointers.
 * This array is mod'd the with the size to find which bucket and then all
 * entries must be searched to see if the tag is in timed wait. If so we
 * reject it.
 */
#define SCTP_STACK_VTAG_HASH_SIZE 31

/*
 * If we use the per-endpoint model than we do not have a hash table of
 * entries but instead have a single head pointer and we must crawl through
 * the entire list.
 */

/*
 * Number of seconds of time wait, tied to MSL value (2 minutes), so 2 * MSL
 * = 4 minutes or 480 seconds.
 */
#define SCTP_TIME_WAIT 480

/* This time wait is the same as the default cookie life
 * since we now enter a tag in every time we send a cookie.
 * We want this shorter to avoid vtag depletion.
 */
#define SCTP_TIME_WAIT_SHORT 60

/* The system retains a cache of free chunks such to
 * cut down on calls the memory allocation system. There
 * is a per association limit of free items and a overall
 * system limit. If either one gets hit then the resource
 * stops being cached.
 */

#define SCTP_DEF_ASOC_RESC_LIMIT 10
#define SCTP_DEF_SYSTEM_RESC_LIMIT 1000



#define IN4_ISPRIVATE_ADDRESS(a) \
   ((((u_char *)&(a)->s_addr)[0] == 10) || \
    ((((u_char *)&(a)->s_addr)[0] == 172) && \
     (((u_char *)&(a)->s_addr)[1] >= 16) && \
     (((u_char *)&(a)->s_addr)[1] <= 32)) || \
    ((((u_char *)&(a)->s_addr)[0] == 192) && \
     (((u_char *)&(a)->s_addr)[1] == 168)))

#define IN4_ISLOOPBACK_ADDRESS(a) \
    ((((u_char *)&(a)->s_addr)[0] == 127) && \
     (((u_char *)&(a)->s_addr)[1] == 0) && \
     (((u_char *)&(a)->s_addr)[2] == 0) && \
     (((u_char *)&(a)->s_addr)[3] == 1))


#if defined(_KERNEL)

#define SCTP_GETTIME_TIMEVAL(x)	(getmicrouptime(x))
#define SCTP_GETPTIME_TIMEVAL(x)	(microuptime(x))
/*#if defined(__FreeBSD__) || defined(__APPLE__)*/
/*#define SCTP_GETTIME_TIMEVAL(x) { \*/
/*	(x)->tv_sec = ticks / 1000; \*/
/*	(x)->tv_usec = (ticks % 1000) * 1000; \*/
/*}*/

/*#else*/
/*#define SCTP_GETTIME_TIMEVAL(x)	(microtime(x))*/
/*#endif				 __FreeBSD__ */

#define sctp_sowwakeup(inp, so) \
do { \
	if (inp->sctp_flags & SCTP_PCB_FLAGS_DONT_WAKE) { \
		inp->sctp_flags |= SCTP_PCB_FLAGS_WAKEOUTPUT; \
	} else { \
		sowwakeup(so); \
	} \
} while (0)

#define sctp_sowwakeup_locked(inp, so) \
do { \
	if (inp->sctp_flags & SCTP_PCB_FLAGS_DONT_WAKE) { \
                SOCKBUF_UNLOCK(&((so)->so_snd)); \
		inp->sctp_flags |= SCTP_PCB_FLAGS_WAKEOUTPUT; \
	} else { \
		sowwakeup_locked(so); \
	} \
} while (0)

#define sctp_sorwakeup(inp, so) \
do { \
	if (inp->sctp_flags & SCTP_PCB_FLAGS_DONT_WAKE) { \
		inp->sctp_flags |= SCTP_PCB_FLAGS_WAKEINPUT; \
	} else { \
		sorwakeup(so); \
	} \
} while (0)

/* FIXME */
#define sctp_sorwakeup_locked(inp, so) \
do { \
	if (inp->sctp_flags & SCTP_PCB_FLAGS_DONT_WAKE) { \
		inp->sctp_flags |= SCTP_PCB_FLAGS_WAKEINPUT; \
                SOCKBUF_UNLOCK(&((so)->so_rcv)); \
	} else { \
		sorwakeup_locked(so); \
	} \
} while (0)

#endif				/* _KERNEL */
#endif
