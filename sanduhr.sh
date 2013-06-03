#!/bin/bash

clear

if [ $# -ne 3 ]
then
	echo "Usage: sanduhr.sh height opening bottomFillLevel"
	exit 1
fi

SAND="#"

H=$1
O=$2
P=$3

let STARS=`echo "($H - 1) * $H + $H * $O" | bc`

#echo $STARS

##########
# top
##########
function top() {
for (( c=1; c<=$H; c++ ))
do
    echo -n "~"
done

for (( c=1; c<=$O; c++ ))
do
   echo -n "~"
done

for (( c=1; c<=$H; c++ ))
do
   echo -n "~"
done

echo
}

#########
# upper glass
#########
function glass() { # parameter: WIDTH MIRROR (true/false) FILL (0/1/2 = null / O / full)
    W=$1
    MIRROR=$2
    FILL=$3

    # Left space
    for (( d=$W; d>=1; d-- ))
    do
        echo -n " "
    done

    # Left \
    [[ "$MIRROR" == "true" ]] && echo -n "/" || echo -n "\\"

    # Still left spaces
    # Inside glass
    let X=`expr $H - $W`
    for (( d=1; d<$X; d++ ))
    do
        [[ "$FILL" == "2" ]] && echo -n "$SAND" || echo -n " "
    done

    # $O spaces
    for (( d=1; d<=$O; d++ ))
    do    
        [[ "$FILL" == "0" ]] && echo -n " " || echo -n "$SAND"
    done

    # Right spaces
    # Inside glass
    for (( d=1; d<$X; d++ ))
    do
        [[ "$FILL" == "2" ]] && echo -n "$SAND" || echo -n " "
    done

    # Right /
    [[ "$MIRROR" == "true" ]] && echo -n "\\" || echo -n "/"

    # Right spaces outside glass
    # Not needed!

   echo 
}


#### MAIN METHOD ####
top

for (( l=0; l<$H; l++ ))
do
    glass $l false $([[ $l -ge $P ]] && echo "2" || echo "0")
done

for (( l=$(echo "$H-1" | bc); l>=0; l-- ))
do
    glass $l true $([[ $l -lt $P ]] && echo "2" || echo "1")
done

top
