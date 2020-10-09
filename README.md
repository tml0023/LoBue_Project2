# LoBue_Project2

## **MOTIVATION** 
This script was written to calculate the GC content of all the sequences in any given file. In order to run this script 
you must include the file containing the sequences as a command line argument. Also, there is a limit of one argument per execution.
### **ARGUMENT VALIDATION**
  The first "if, else" statement is used to confirm only one argument was included with the script. If there is only one argument 
  you will get a message saying "Correct number of arguments. If number of arguments is not one than you will get an error message, 
  "Wrong number of arguments.
  
    #! /bin/bash
  
    ##check to see the number of arguments####
    if [ $# -eq 1 ] ; then
      echo "Correct number of arguments"
    else
      echo "Wrong number of arguments"
    fi

  This "if, else" statement is used to confirm the argument included with the script actually exists and has content. If this is not the 
  case then you will get an error, "Include file as arguement when executing." If the argument does exist and has content then you will recieve a message 
  saying, "orrect arguement input".

    ###Check for correct command line arguement and count sequences####
    if [ -e $1 ] ; then
      echo "Correct arguement input"
    else
      echo "Include file as arguement when executing."
    fi

### **VARIABLE ASSIGNMENT**
  Here we will assign variables for the number of sequences included in the given file which will help later in the script. 
  We also assign variables to the name of each sequence and to the sequence itself. This will make it easier when calculating the GC count and when
  moving these outputs to the output file.
  
    ###create variables for the number of sequences, the names of the sequences,
    ###and the sequences

    SN=$(grep '>' $1 | wc -l)
    #echo $SN

    names=($(grep '>' $1))
    #echo "${names[2]}"

    seq=($(grep -v '>' $1))
    #echo "${seq[0]}"

### CALCULATING GC CONTENT
  The first step in this section is to create the output file and input the headers for each column of this file. 
  Next we need to create a loop to run as many times as there are sequences in the file. This is where we utilize the 
  variable for the number of sequences in the file created earlier. Within each loop we want the script to count the total number of 
  each nucleotide per sequence and then calculate the percentage of G's and C's and move this information to the output file. 
  
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
    
### **OUTPUT TABLE**

| Sequence name |	GC percentage |
| ------------ |  ------------- |
| >DI245396.1 |	43% |
| >DI245395.1 |	42% |
| >HW262829.1 |	43% |
| >546218138 |	42% |
| >X13802.1 |	39% |
| >NM_001179558.3 |	51% |
| >NM_001178613.2 |	45% |
| >AY558240.1 |	51% |
| >AB052924.1 |	51% |
