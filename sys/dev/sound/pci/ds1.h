/*
 * =======================================================================
 *	title		: define
 *	company		: YAMAHA
 *	author		: Taichi Sugiyama
 *	create Data     : 28/Sep/99
 * =======================================================================
 * $FreeBSD$
 */


/* ----- YAMAHA DS-XG Devices -------------------------------------------- */
#define	YAMAHA		0x1073
#define	YMF724		0x0004
#define	YMF724F		0x000d
#define	YMF734		0x0005
#define	YMF737		0x0008
#define	YMF738		0x0020
#define	YMF740		0x000a
#define	YMF740C		0x000c
#define	YMF744		0x0010
#define	YMF754		0x0012
#define	YMF738_TEG	0x0006
#define DEVICE4CH(x)	((x == YMF738) || (x == YMF744) || (x == YMF754))


#define	PCIR_DSXGCTRL		0x48
/* ----- interrupt flag -------------------------------------------------- */
#define	YDSXG_DEFINT				0x01
#define	YDSXG_TIMERINT				0x02


/* ----- AC97 ------------------------------------------------------------ */
#define	YDSXG_AC97TIMEOUT			1000
#define	YDSXG_AC97READCMD			0x8000
#define	YDSXG_AC97WRITECMD			0x0000
#define	YDSXG_AC97READFALSE			0xFFFF


/* ----- AC97 register map _---------------------------------------------- */
#define	AC97R_GPIOSTATUS			0x54


/* ----- work buffer ----------------------------------------------------- */
#define	DEF_WORKBUFFLENGTH			0x0400


/* ----- register size --------------------------------------------------- */
#define	YDSXG_MAPLENGTH				0x8000
#define	YDSXG_DSPLENGTH				0x0080
#define	YDSXG_CTRLLENGTH			0x3000


/* ----- register map ---------------------------------------------------- */
#define	YDSXGR_INTFLAG				0x0004
#define	YDSXGR_ACTIVITY				0x0006
#define	YDSXGR_GLOBALCTRL			0x0008
#define	YDSXGR_ZVCTRL				0x000A
#define	YDSXGR_TIMERCTRL			0x0010
#define	YDSXGR_TIMERCOUNT			0x0012
#define	YDSXGR_SPDIFOUTCTRL			0x0018
#define	YDSXGR_SPDIFOUTSTATUS		0x001C
#define	YDSXGR_EEPROMCTRL			0x0020
#define	YDSXGR_SPDIFINCTRL			0x0034
#define	YDSXGR_SPDIFINSTATUS		0x0038
#define	YDSXGR_DSPPROGRAMDL			0x0048
#define	YDSXGR_DLCNTRL				0x004C
#define	YDSXGR_GPIOININTFLAG		0x0050
#define	YDSXGR_GPIOININTENABLE		0x0052
#define	YDSXGR_GPIOINSTATUS			0x0054
#define	YDSXGR_GPIOOUTCTRL			0x0056
#define	YDSXGR_GPIOFUNCENABLE		0x0058
#define	YDSXGR_GPIOTYPECONFIG		0x005A
#define	YDSXGR_AC97CMDDATA			0x0060
#define	YDSXGR_AC97CMDADR			0x0062
#define	YDSXGR_PRISTATUSDATA		0x0064
#define	YDSXGR_PRISTATUSADR			0x0066
#define	YDSXGR_SECSTATUSDATA		0x0068
#define	YDSXGR_SECSTATUSADR			0x006A
#define	YDSXGR_SECCONFIG			0x0070
#define	YDSXGR_LEGACYOUTVOL			0x0080
#define	YDSXGR_LEGACYOUTVOLL		0x0080
#define	YDSXGR_LEGACYOUTVOLR		0x0082
#define	YDSXGR_NATIVEDACOUTVOL		0x0084
#define	YDSXGR_NATIVEDACOUTVOLL		0x0084
#define	YDSXGR_NATIVEDACOUTVOLR		0x0086
#define	YDSXGR_SPDIFOUTVOL			0x0088
#define	YDSXGR_SPDIFOUTVOLL			0x0088
#define	YDSXGR_SPDIFOUTVOLR			0x008A
#define	YDSXGR_AC3OUTVOL			0x008C
#define	YDSXGR_AC3OUTVOLL			0x008C
#define	YDSXGR_AC3OUTVOLR			0x008E
#define	YDSXGR_PRIADCOUTVOL			0x0090
#define	YDSXGR_PRIADCOUTVOLL		0x0090
#define	YDSXGR_PRIADCOUTVOLR		0x0092
#define	YDSXGR_LEGACYLOOPVOL		0x0094
#define	YDSXGR_LEGACYLOOPVOLL		0x0094
#define	YDSXGR_LEGACYLOOPVOLR		0x0096
#define	YDSXGR_NATIVEDACLOOPVOL		0x0098
#define	YDSXGR_NATIVEDACLOOPVOLL	0x0098
#define	YDSXGR_NATIVEDACLOOPVOLR	0x009A
#define	YDSXGR_SPDIFLOOPVOL			0x009C
#define	YDSXGR_SPDIFLOOPVOLL		0x009E
#define	YDSXGR_SPDIFLOOPVOLR		0x009E
#define	YDSXGR_AC3LOOPVOL			0x00A0
#define	YDSXGR_AC3LOOPVOLL			0x00A0
#define	YDSXGR_AC3LOOPVOLR			0x00A2
#define	YDSXGR_PRIADCLOOPVOL		0x00A4
#define	YDSXGR_PRIADCLOOPVOLL		0x00A4
#define	YDSXGR_PRIADCLOOPVOLR		0x00A6
#define	YDSXGR_NATIVEADCINVOL		0x00A8
#define	YDSXGR_NATIVEADCINVOLL		0x00A8
#define	YDSXGR_NATIVEADCINVOLR		0x00AA
#define	YDSXGR_NATIVEDACINVOL		0x00AC
#define	YDSXGR_NATIVEDACINVOLL		0x00AC
#define	YDSXGR_NATIVEDACINVOLR		0x00AE
#define	YDSXGR_BUF441OUTVOL			0x00B0
#define	YDSXGR_BUF441OUTVOLL		0x00B0
#define	YDSXGR_BUF441OUTVOLR		0x00B2
#define	YDSXGR_BUF441LOOPVOL		0x00B4
#define	YDSXGR_BUF441LOOPVOLL		0x00B4
#define	YDSXGR_BUF441LOOPVOLR		0x00B6
#define	YDSXGR_SPDIFOUTVOL2			0x00B8
#define	YDSXGR_SPDIFOUTVOL2L		0x00B8
#define	YDSXGR_SPDIFOUTVOL2R		0x00BA
#define	YDSXGR_SPDIFLOOPVOL2		0x00BC
#define	YDSXGR_SPDIFLOOPVOL2L		0x00BC
#define	YDSXGR_SPDIFLOOPVOL2R		0x00BE
#define	YDSXGR_ADCSLOTSR			0x00C0
#define	YDSXGR_RECSLOTSR			0x00C4
#define	YDSXGR_ADCFORMAT			0x00C8
#define	YDSXGR_RECFORMAT			0x00CC
#define	YDSXGR_P44SLOTSR			0x00D0
#define	YDSXGR_STATUS				0x0100
#define	YDSXGR_CTRLSELECT			0x0104
#define	YDSXGR_MODE					0x0108
#define	YDSXGR_SAMPLECOUNT			0x010C
#define	YDSXGR_NUMOFSAMPLES			0x0110
#define	YDSXGR_CONFIG				0x0114
#define	YDSXGR_PLAYCTRLSIZE			0x0140
#define	YDSXGR_RECCTRLSIZE			0x0144
#define	YDSXGR_EFFCTRLSIZE			0x0148
#define	YDSXGR_WORKSIZE				0x014C
#define	YDSXGR_MAPOFREC				0x0150
#define	YDSXGR_MAPOFEFFECT			0x0154
#define	YDSXGR_PLAYCTRLBASE			0x0158
#define	YDSXGR_RECCTRLBASE			0x015C
#define	YDSXGR_EFFCTRLBASE			0x0160
#define	YDSXGR_WORKBASE				0x0164
#define	YDSXGR_DSPINSTRAM			0x1000
#define	YDSXGR_CTRLINSTRAM			0x4000


/* ----- time out -------------------------------------------------------- */
#define	YDSXG_WORKBITTIMEOUT		250000

