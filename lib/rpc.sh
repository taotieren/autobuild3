#!/bin/bash
##rpc.sh: remote-or-local commands.
##@copyright GPL-2.0+
# todo: rebase 'data', screw bool
if [ "$CROSS" ]; then
	if [ ! -f "/var/ab/cross-rpc/$CROSS" ]; then
		RPC_CHROOT=true
	else
		RPC_CHROOT=false
		source /var/ab/cross-rpc/$CROSS
	fi
fi
[ "$RPC_PORT" ] || RPC_PORT=22

# todo: use cp-l
rpc_cp(){
	(($# < 2)) || return 42
	if ! [ "$CROSS" ]; then
		cp -a "$@"
	elif bool $RPC_CHROOT; then
		#      argv[:-1]                                argv[-1]
		cp -a "${@:1:$#-1}" "/var/ab/cross-root/$CROSS/${@:$#:1}"
	else
		scp -pr -P "$RPC_PORT" "${@:1:$#-1}" "$RPC_SERVER":"${@:$#:1}"
	fi
}

rpc_exe(){
	if ! [ "$CROSS" ]; then
		( eval "$1" )
	elif bool $RPC_CHROOT; then
		chroot /var/ab/cross-root/"$CROSS"   bash -c "$1"
	else
		ssh -tt -p "$RPC_PORT" "$RPC_SERVER" bash -c "$1"
	fi
}
