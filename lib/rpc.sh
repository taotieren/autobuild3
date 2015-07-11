
if [ "$CROSS" ]; then
	if [ ! -f "/var/ab/cross-rpc/$CROSS" ]; then
		RPC_CHROOT=true
	fi
else
	RPC_CHROOT=false
	source /var/ab/cross-rpc/$CROSS
fi
[ "$RPC_PORT" ] || RPC_PORT=22

rpc_cp(){
	if ! [ "$CROSS" ]; then
		cp $1 $2
	elif bool $RPC_CHROOT; then
		cp $1 /var/ab/cross-root/$CROSS/$2
	else
		scp -P $RPC_PORT $1 $RPC_SERVER:$2
	fi
}
rpc_exe(){
	if ! [ "$CROSS" ]; then
		eval "$*"
	elif bool $RPC_CHROOT; then
		chroot /var/ab/cross-root/$CROSS $*
	else
		ssh -p $RPC_PORT $RPC_SERVER $*
	fi
}
