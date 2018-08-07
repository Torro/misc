#!/bin/bash
# This calculates a very simple and inaccurate bandwidth utilization percentage on a full-duplex link.

INTERVAL="10"  # update interval in seconds

if [ -z "$2" ]; then
        echo
        echo usage: $0 [network-interface] [uplink speed in megabit per second]
        echo
        echo e.g. $0 eth0 10
        echo
        exit
fi

IF=$1
IFBPS=$(($2 * 1000000))

R1=`cat /sys/class/net/$1/statistics/rx_bytes`
T1=`cat /sys/class/net/$1/statistics/tx_bytes`
sleep $INTERVAL
R2=`cat /sys/class/net/$1/statistics/rx_bytes`
T2=`cat /sys/class/net/$1/statistics/tx_bytes`
TBPS=`expr $T2 - $T1`
RBPS=`expr $R2 - $R1`
MAXBPS=$((TBPS > RBPS ? TBPS : RBPS))
BWUTIL=$(echo "scale=2;($MAXBPS*8*100) / ($INTERVAL * $IFBPS)" | bc)

echo "$BWUTIL% capacity"

TUNNO=`ip tuntap | wc -l`
echo "$TUNNO user(s)"
