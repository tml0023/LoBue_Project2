#! /bin/bash


##check to see the number of arguments####
if [ $# -eq 1 ] ; then
	echo "Correct number of arguments"
else
	echo "Wrong number of arguments"
fi

###Check for correct command line arguement and count sequences####
if [ -e $1 ] ; then
	echo "Correct arguement input"
else
	echo "Include file as arguement when executing."
fi

###create variables for the number of sequences, the names of the sequences,
###and the sequences

SN=$(grep '>' $1 | wc -l)
#echo $SN

names=($(grep '>' $1))
#echo "${names[2]}"

seq=($(grep -v '>' $1))
#echo "${seq[0]}"

###Create the output file and insert the header###
	touch GCcount.txt
	echo -e "Sequence name\tGC percentage" > GCcount.txt

###create for loop to count the GC content for each sequence in the
###given file and export this data to the output file
for (( i=0; i<=$SN; i++ ))
do

G=($( echo "${seq[$i]}" | grep -o -e "G" | wc -l ))
C=($( echo "${seq[$i]}" | grep -o -e "C" | wc -l ))
A=($( echo "${seq[$i]}" | grep -o -e "A" | wc -l ))
T=($( echo "${seq[$i]}" | grep -o -e "T" | wc -l ))
GC=`expr $G + $C`
ALL=`expr $GC + $A + $T`
#echo $GC
#echo $ALL
GCpercent=`expr $GC \* 100 / $ALL`
#echo $GCpercent
echo -e "${names[$i]}\t$GCpercent%" >> GCcount.txt

done



