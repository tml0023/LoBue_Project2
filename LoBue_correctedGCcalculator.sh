#! /bin/bash


##check to see the number of arguments####
if [ $# != 1 ] ; then
	echo "Wrong number of arguments"
exit #### here I added the exit command to quit the script if there is more or less than one arguement ###
fi

###Check for correct command line arguement and count sequences####
if [ -s $1 ] ; then
	echo "Correct arguement input. Continuing..."
else
	echo "File does not exist or is empty."
fi

###create variables for the number of sequences, the names of the sequences,
###and the sequences

nseq=$(grep ">" $1 | wc -l)
echo "There are $nseq sequences in the $1 file"

###Create the output file and insert the header###
touch GCcount.txt
echo -e "Sequence_name\tGC _percentage" > GCcount.txt

## sort the sequences and headers into arrays
names=(`grep ">" $1 | tr -d ">"`) #could also use sed
seqs=(`grep -v ">" $1`)

###create for loop to count the GC content for each sequence in the
###given file and export this data to the output file
for ((i=0; i<$nseq; i++))
do
#printing sequences from array without new line characters and counting the occurances of G|C|Allcharacters, no matter the case
G=`echo -n ${seqs[$i]}|grep -oi "G"|wc -l`
C=`echo -n ${seqs[$i]}|grep -oi "C"|wc -l`
T=`echo -n ${seqs[$i]}| wc -m`

#calculating the GC %
GCp=`echo "scale=3; ((($G + $C)/$T)*100)"|bc`

#output into file
echo -e "${names[$i]}\t$GCp" >> GCcount.txt
done
