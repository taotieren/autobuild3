abreqexe find

fileenum() {
	for i in `find .`
	do
		[ ! -e $i ] && continue
		eval `echo $1 | sed "s@{}@$i@g"`
	done
}
