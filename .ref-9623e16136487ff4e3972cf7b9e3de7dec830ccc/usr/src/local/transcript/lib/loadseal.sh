#!/bin/sh
#	@(#)loadseal.sh	1.1 (Berkeley) %G%
# Download UC Seal into Postscript printer's memory
# Original version, Conrad Huang, UCSF Computer Graphics Lab, 1985
# Printer defaulting added, Greg Couch, UC Berkeley Unigrafix Group, 1987
printer=-P${PRINTER=PostScript}
while test $# != 0
do	case "$1" in
	-P*)	printer=$1 ;;
	esac
	shift
done
lpr $printer -h << EOF
%!
/ucseal where
{pop(UC seal in place\n)print flush stop}
{serverdict begin statusdict begin 0 checkpassword
 {(UC font downloaded.\n)print flush 0 exitserver}
 {(Bad Password on loading UC seal!!!\n)print flush}ifelse
 end%statusdict
}
ifelse
% the image comes in with upper left pixel first,
% scanning to the right then down with lower right pixel last
/ucsealmask <
00000000000000000000000000079e3c7000000000000000000000000000
00000000000000000000000003cf9f3cf9e0000000000000000000000000
000000000000000000000000e3cf9f3cf9f3c00000000000000000000000
000000000000000000000011f3c79e3c79f3c20000000000000000000000
000000000000000000000079f3c3000031e3cf0000000000000000000000
000000000000000000000879f00000000003cf8800000000000000000000
000000000000000000001e780000000000000f9e00000000000000000000
000000000000000000003e780000000000000f3e00000000000000000000
0000000000000000000f3e00000000000000003e78000000000000000000
0000000000000000000f9c00000000000000001e78000000000000000000
0000000000000000008f8000000ffffff800000078400000000000000000
000000000000000003cf000007fffffffff0000079e00000000000000000
000000000000000003e00000fffc00001fff800001e00000000000000000
000000000000000023e00007fe000000003ff80001e10000000000000000
0000000000000000f1c0007fc00000000001ff0001e78000000000000000
0000000000000000f80003fc0000000000001fe000078000000000000000
0000000000000000f8001fe000003800000001fc00078000000000000000
000000000000001c70007f00001c38000000003f00079e00000000000000
000000000000003e0001f800001e38000007000fe0003e00000000000000
000000000000003e000fc003e00e7000001fc001f8003e00000000000000
000000000000001e003f001fe00f7000003fe0007e001e00000000000000
000000000000078000fc007f800760000078f0000f8000f0000000000000
000000000000078003f0007f0003e0070070700003e000f8000000000000
000000000000078007c000070003e00f80e0380000f800f0000000000000
00000000000007801f00e0038001c00f80e03803807e00f0000000000000
000000000000f0007c00e0038001c08700e03803e01f0003c00000000000
000000000000f000f00070038001c0c000e03807f807c007c00000000000
000000000000f003e0007003c001c1c000e070077e01e007c00000000000
000000000000f00780007801c000e1c000f0f00f1e00f803c00000000000
00000000001e001f01803801c000c1e00079e00e04003c001c0000000000
00000000001e003c07e03c01c00003e0003fe01f80001e003e0000000000
00000000003e00781fe01c00e00003f0001fc01fe00007803e0000000000
00000000001e01e01c401c00c0003efe0000003df00003c01e0000000000
00000000000c03c038000e00003ffefffe000038300001e01c0000000000
0000000003c00780387c0e0007fffcfffff000380000007001e000000000
0000000003c00f003ffe0e007ff00cf807ff00700000003c01f000000000
0000000003c01c001ffe0003fe000cfc003fe0100070001e01f000000000
0000000003c078001f8e001fe001f8ffc003fc0000f8000f01e000000000
000000000000f0000006007f03fffcfffff07f0000f80007800000000000
000000007801e000000e01f803fffef007e00fe000780003c00f00000000
000000007c03c00003bc07c001dfffe1ffc001f8000003e1e00f00000000
000000007c0783e003f81ffffc707fffff80007e00000ff0f00f00000000
00000000380f07f003f07c00003803fffe00001f80001ff8780f00000000
00000000001e0f700001f000001c01f81c7ffff7c0003e3c3c0000000000
00000007801c1e300007c000000703ff380001fff000781c1e00f0000000
0000000780383c3c000f000000e307bfe00000007c00701c0f00f0000000
00000007c070787e003e00000fc1079fe60000001e00701c0780f0000000
0000000780e03cff00780000fc030f8fe7c000000f80701c0380f0000000
0000000001c01fe7c1f0001fc0031f8fe0f8000003c0700c01c000000000
0000003803c00fc383c001f800333f87e61e000001e0700000e006000000
0000007c0380078107801f8000f37f83e783c00000f8798000700f000000
0000007c070007c00f03f80001c27fe1f5c07800003c3fc000780f000000
0000007c0e0003e03c3f00000716ff78f2701f00001e1fc000380f000000
000000381c0001f07bf000001c27fc1ef31c03e0000f0200001c06000000
000000001c3000f0ff00000070e7f087f18f007c00078000000e00000000
000003c038700061f0000001e1c7c3a1f0e3800f8003c000000e00e00000
000003c070e00003c000000383270da87a70e001e000e000000701f00000
000003c071e300078000000e06643faa191838003c00700007c381f00000
000003c0e1c7000f000000381cc0ffbd018c1e00078038007fc381f00000
00000001c38f001e000000e039837fbda1c7070001f01c03ffc1c0000000
00000001c78e183c000003c06303fa95b0e381c0003e1e0ffbc0e0000000
00001e0387dc383800000700ffffea95ffffc0700007cf0fc780e01e0000
00003e0383fc70700ff81dfffffffa9ffffffffc0ff8ff84e700701e0000
00003e0700f870e00fffffff00003ebe00003ffffff81f80ff00701e0000
00001e06007ee1c00dffff80000007f80000003fffe803c07e00381e0000
0000000e001fc3c00d8cc000000003e000000000c66800e03c0038000000
0000000c000fc3800d8cc000000001e000000000c66800f038001c000000
0000f01c000387000d8cc00005ffc1c0fffc0000c668007078000c03c000
0001f01800010e000d8cc7fffdffe0c3fffffff8c668003870000e07c000
0001f03800000e000d8cc7ffc00078c700007ff8c668001c60000607c000
0000f03080001c000d8cc606000018ce00000000c668001c00000703c000
00000070c00038001d8cc6c6000018cc00000000c668000e0000c3000000
00000060f00038007d8cc6c6000000c000000000c66e00060003c3800000
000780e0f8007001cd8cc7e6000000c000000000c66b8007000fe380f000
000780c03c0070078d8cc7e63f7fc0c1ffff8000c669e003807f81c0f000
0007c1c01e00e00e0d8cc7e7ff7bf0c7f7fffff8c668700381fe01c0f000
000781c00f00c0380d8cc736000030c600000ff8c6681c01c3f000c0f000
000001800781c0e00d8cc636000018cc00000000c6680701c3c000e00000
00000387e3c183800d8cc606000018cc00000000c66803c0e38000e00000
000c038fffe38f000d8cc606000000c000000000c66800e0e1c000601c00
001e030fffe31c000d8cc7fe000000c000000000c668003871c000703c00
001e070000c770000d8cc003ffffc0c3fffff000c668000e70c000303e00
001e06000007c0000d8cc7ffff01f0c7c03ffff8c6680007b0e000303c00
000c0600000f00000d8cc7e0000038c6000001f8c66c0001f86000381c00
00000e00000e00001d8cc000000018cc00000000c66e0000780000180000
00000e00000c00003d8cc000000018cc00000000c66b80001c0000180000
00780c00001c00006d8cc000000000c000000000c669c0001c001e1c0f00
007c0c38001c0001cd8cc00000fe00c03fc00000c668e0000c01ff1c0f00
007c1c3f801800038d8cc01fffffe0c3fffffe00c66830000e0ffe0c0f00
0078183ff83800070d8cc7fff00070c70007fff8c6681c000e3fe00c0f00
00001807fe38000c0d8cc000000018ce00000000c6680e00061f000e0000
000018007e3000380d8cc000000018cc00000000c66807000710000e0000
00f038000e7000700d8cc000000000c000000000c6680180070000060380
00f03000007000e00d8cc000000000c000000000c66800e00300000607c0
00f03000006001800d8cc00003ffc0c0fffc0000c66800700300000607c0
00f03000006003000d8cc7effffff0c3fffffff8c66800180380008707c0
0060300000600e001d8cc7efc00078c700007ff8c668000c03807f870380
0000700000e01c001d8cc000000018ce00000000c6680007018fffc30000
000071ff00e030003d8cc000000018cc00000000c66f8003818fffc30000
01e061fff0c060006d8cc000000000c000000000c66fe040c18fb9c303c0
01e060fff0c1c000cd8cc000000000c000000000c66f706061c038c303e0
01e06001f0c380018d8cc0003fffc0c1f7ff8000c66b387039c038c303e0
01e06007e1c600030d8cc7fffffbe0c7f7fffff8c6699c781cc018c383c0
0000601f81cc00060d8cc7fc000038c600000ff8c669cc7806c018e38000
000060fc01b8000c0d8cc000000018cc00000000c668ce6c03c018e18000
01c0e3f001f000180d8cc000000018cc00000003fe68663c01c0000180c0
03e0e3ff01c000300d8cc000000000c000000007fe68763600c0000181e0
03e0e3ffe18000600d8cc000000000c00000000e0e68333600c0000181e0
03e0c1ffe18000c00d8cc001ffffe0c3fffff01c07681b6600e0000181e0
01c0c000e18001800d8cc7fffe0170c7c03ffff803681be600e0000181e0
0000c000018003000d8cc7e0000038c6000001f003681bc600e000018000
0000c000018006000d8cc000000018cc00000060ffe8198e006000018000
03c0c00001800c001d8cc000000018cc00000063ffec798c0060000181e0
03c0c000018018003d8cc000000000c0000000c7c7ffe01c00607e0181e0
03e0c000018030003d8cc00000fe00c03fc000cec7ff80380061ff8181f0
03c0c000018060006d8cc01fffffc0c3fffffedcc6e000f80063ffc181e0
0180c0000180e000cd8cc7fff80070c78007ffd8c67c07cc0063c3c180c0
0000c0000181c000cd8cc000000018ce000001b8c67fff86006700e18000
0000c3ffc18380018d8cc000000018cc000001b0c66bf80300e700e18000
03c0c3ffe18700030d8cc000000000c0000001b0c668600180e700e181e0
03e0c3ffe18e00060d8cc000000000c0000001b0c6683000c0e700e181e0
03e0e000719c00060d8cc00007ffc0c0fff801e0c6fc180060c780e181e0
03c0e00071b8000c0d8cc7ffdffff0c3fffbfff8cfff8c0030c3c3c181e0
0000e00071b000180d8cc7ffc00038c700007ff8ff03ec0018c3ffc18000
0000600071e000300d8cc000000018ce000000fff800f6000cc0ff818000
00c06007e1c000300d8cc000000018cc000000cfc0003b000ec03e0381c0
01e063ffe1c000600d8cc000000000c0000000e0003ffd8007c0000383e0
01e061ffc0c000c00d8cc000000000c00000006001fcff8003c0000303e0
01e061f000c001800d8cc0003fffc0c1ffff80300fe83fc001c0000303e0
01e0600000c001800d8cc7fffffbe0c7f7ffbffffe681fe00180000301c0
0000700000c003000d8cc7fe000038c600000ffff6681bb0018000030000
0000700000e006000d8cc000000018cc00000000c66c19f0018000030000
00f0300000600c000d8cc000000018cc00000000c66c18f8038000070380
00f0300000600c000ffec000000000c000000000c66e187c030c000707c0
00f03000006018000fffc000000000c000000000c66a1876030f800607c0
00f03801e07030001c03e003ffffe0c3fffff000c66b1836030ff0060780
00003801e03060001800f7ffff0170c7c03ffff0c66998330707ff060000
00001801e030600030003fe0000038c6000001f0c669981186007f8e0000
00101801e038c00030001c00000018cc00000000c668d819c600ef8c0200
007c180040398000e0000e00000018cc00000000c668f818ce00e38c0f00
007c1c00001b0001e0070700000000c000000000c66870106e00c30c0f00
007c0c00001f0003800e038000ff00c03ffffc00c66860303c3fc71c0f00
00380c00001e0003001c01dfffffe0c3ffc1fffcc669e0303c3fc7180f00
00000e00000c0007803800fff80070c79c0080fffe7f8030187fee180000
00000e00018e000fe0703060000018ce18018001fffe00601800fe380000
001e060001c6000ff0307830000018cc0801840000fc006038007c383c00
001e070001c7001fbc19cc38000000c00c010c3cc6f000c0300000303c00
001e070030c7001b0e0be61fc00000c00c030c7ec61001c0700000703e00
001e030238e380330f83710ffff800c038030cc6c6100380600000703c00
0000038638e380330dc3318603ffe0c3f80218c0fe100700e00000600000
000003871c71c0630de180c70001fcdf9f83f89efe180f80c00000e00000
000381871cf1c0638df8c1e3ffffdfffffe078c6c6183c81c30000e07000
000781c38ff0e061cdbcc3b1e007fbfff07810ee4618f0c1878000c0f000
0007c0c39fe0e040ed8e0600c1fc1dfce0ff007e4603e06387e001c0f000
000780e1ff8070607d870c007fffeff3c0fff004001f806301f80180f000
000380e1fc00707ffd8388007000ffff6060ff0001fe0037007e03807000
00000070f000387f0dffc00038003c1e70300fffffe8003e003f83000000
00006070c0001c600dffe0001c0038063c38007ffe08001e000fc7038000
0000f03000001cc00ffff0008ffff007fffffffffff8001c3fffc703c000
0001f03800000e800ffff800c7fff80ffffffffffff800383fff8e07c000
0001f0180003878003031c0063881ffc00ce0100006000387e000e07c000
0000f01c0007c70003033e00f1c807f0004f0100003000701f801c038000
0000000c001f83800702370198e80080005b8180003000e007e01c000000
00001c0e003e01c007062383047800800059c080001001e001f8380c0000
00003e07007c01e00f0661c60c1e00800078c080001801c000fc381e0000
00003e0701fc00f00f8660e4180f80800070e0c000080384003c701e0000
00003e0383fc1870098340703843e08000f060c0000c070f0008601e0000
00001c0383ce3c3818c3c0387cc0fc8001e06040000c0e0f8000e01c0000
00000001c30f7c1c10c7e01c67901fe01f80304000061e07c001c0000000
00000380e007f80e30c6f80e033801fffe38306000063c01f001c0e00000
000003c0e003e007308fb80e066e0003c0f0306000027800f80381f00000
000003c0700fc003a08ff80f0ce6c000008030200003f0007c0701f00000
000003c0381f0003e089ff0b88f0f000fcdc30200001e1801f0701f00000
00000380383e0000e0cd1f89c1b9b9f8ccf830300003c1c00f0e00e00000
000000001c18000070ef0f88e1898980cc406030000781c0061c00000000
000000380e00000c3c7f079871c1d9807c66e010000f00e0001c0f000000
0000007c0f00001e1e3e0018307379f0667ec010001e01e000380f000000
0000007c0700001e0f1b0010383311006671c018007803f000700f000000
000000780380003c079f9f101c0231007e03807c00f077f000e00f000000
0000000001c0007803effff00e0031f0780f03ff01e0ff7801e000000000
0000000381e000f000fc7bfc070030f0003c1ff707c07e3801c060000000
0000000780f071e0007ce03f03c0000000787e038f001fbc0380f0000000
00000007c0787bc0001ef007c0f0000003e9f807be0007fc0700f0000000
0000000780383f80000ff801e03f00003f8be007f80001fe0e00f0000000
00000003801c1f000003f800782ff80ffc0f800ff000007c1c0070000000
00000000100e0f000001fc003c60ffffc00e001fc00000183c0400000000
000000007c07078018007e001c600080001c003f000e0000780f00000000
000000007c0383c03c001e000c600080001c003c001f0000f00f00000000
000000007c01c0c03e001e001c400080001e003e001f0001e00f00000000
000000003800e0003c00380ffc400080000ff80e000f0003c00f00000000
00000000018078001c00380ff8400080000ff8060000000780e000000000
0000000003c03c000000300ff8400080000ff8060000000f01f000000000
0000000003c01e0000003006ffc00080007ff0060000001c01f000000000
0000000003c00f000000300e1ffe00801ffe38070000007801f000000000
0000000003c007800000300e01ffffffffc01c07000000f000e000000000
00000000001c03e00000301c0007fffff8001c03000001e01c0000000000
00000000001e00f0000070380000000000000e03000003c03e0000000000
00000000003e007800007078000000000000070300000f003e0000000000
00000000001e003e00007070000000000000038300001e001e0000000000
00000000000c600f000060e000c0000001e003c300007c039c0000000000
000000000000f007c00061c001c0f80fc3f801c30000f007c00000000000
000000000000f001e00063800fc1fc1fc7b800e30003e007c00000000000
000000000000f000f800778f0fc1dc38c7183877800f8007c00000000000
000000000000e1003e007f1f01838e3807387c3f801f0023800000000000
00000000000007801f00fe1f03838e3f87f07c3f807c00f0000000000000
000000000000078007c0dc0e0381fc3fc3fc381d81f000f8000000000000
000000000000078001f1dc000381f83de39c000dc7c000f0000000000000
000000000000079c007fd8000383fc38e39e000eff001c70000000000000
000000000000003e001fb80003838e38630e0006fc001e00000000000000
000000000000003e0000380007030e18e39c000600003e00000000000000
000000000000003e20003c0007039e1ce3fc001e00011e00000000000000
000000000000001cf0001f800703fc1fc1f8007c00079c00000000000000
0000000000000000f8000ff00001f80f806007f800078000000000000000
0000000000000000f80001fe0000700000003fc000078000000000000000
000000000000000073c0003ff00000000003fe0001e78000000000000000
000000000000000003e00003ff80000000ffe00001e00000000000000000
000000000000000003e700003fffc001fffe000031e00000000000000000
000000000000000003cf800001ffffffffc0000079e00000000000000000
0000000000000000000f80000001ffffc000000078000000000000000000
0000000000000000000f9e00000000000000001e78000000000000000000
000000000000000000073e10000000000000023e78000000000000000000
000000000000000000003e780000000000000f3e00000000000000000000
000000000000000000001c78e000000000038f9e00000000000000000000
000000000000000000000079f180000000e3cf8000000000000000000000
000000000000000000000079f3c7040871e3cf0000000000000000000000
000000000000000000000001f3cf9e3cf9f3c00000000000000000000000
000000000000000000000000e3cf9f3cf9e3800000000000000000000000
00000000000000000000000003cf9f3cf8e0000000000000000000000000
00000000000000000000000000030e3c3000000000000000000000000000
> def	  

/ucseal {
gsave

72 300 div dup scale		% get to 300 units per inch

/iwid 30 8 mul def
/iheight 229 def

iwid iheight scale		% now the "unit square" is the size of the

iwid iheight true [iwid 0 0 iheight neg 0 iheight] {ucsealmask} imagemask
				
%iwid iheight 1 [iwid 0 0 iheight neg 0 iheight] {ucsealmask} image
grestore
} def 
EOF
