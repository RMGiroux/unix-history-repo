/^[^.].*\\f/{
	s/\\f/@/g
	s/@P/@R/g
	s/ @\(.\)\([^@]*\)@R\([^ @]*\)  */\
.\1R "\2" "\3"\
/
	s/ @\(.\)\([^@]*\)@R\([^ @]*\) *$/\
.\1R "\2" "\3"/
	s/@\(.\) \([^@]*\)@R\([^ @]*\)  */\
.\1R "\2" "\3"\
/
	s/@\(.\) \([^@]*\)@R\([^ @]*\) *$/\
.\1R "\2" "\3"/
	s/@/\\f/g
}
/^\.[TH]P/,/^\.PP/s/^\.DP/.IP/
s/^\.DP/.PP/
/^\.[BIR][BIR]/s/[ ]*""$//
/^\.\([BIR]\)[BIR][^"]*"[^"]*"$/s/.\(.\)./.\1 /
:x
/^\.[^"]*"[^" 	][^" 	]*"/{
	s/"//
	s///
	bx
}
P
D
