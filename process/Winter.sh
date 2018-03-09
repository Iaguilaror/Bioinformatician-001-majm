## Winter Genomics Evaluation report
## Applicants original answer will be commented in this block:

## Observation 1:
# Script is not properly indented. The readability is low.
# Script is not properly commented, example: "En esta linea es eliminar", its not a complete sentence.
# Script is not commented in english
# File names used are not descriptiva of what the file stores
# WG will be indenting the code to make it more readable.

## Observation 2:
# Script DID NOT RUN out of the box. Code was run from process/ via `bash Winter.sh`
# Proper executions requires the tester to move input data from the provided directory at ../ via:
#	`mv ../test-materials/test-data/raw_coverages_by_base.tsv .`

## Observation 3:
# Script DID NOT WORK. 
# Script was not properly tested
# Running `bash Winter.sh` yielded the following error
#```
#	sed: can't read Coverage_raw.txt: No such file or directory
#	awk: fatal: cannot open file `Coverage_raw.txt' for reading (No such file or directory)
#```

#Elimino la primera fila para comodidad
## Observation: awk NR>1 would have solved this issue in the following block of code
sed '1d' raw_coverages_by_base.tsv > Winter.tsv

# En esta linea es eliminar u omitir las lineas donde el campo Depth_by_base sea cero posterior a esto se va contando cuantas veces se encuentra el dato en genes y a la par suma los datos en depth_by_base en cada categoría (gene) y termina calculando la diferencia entre el inicio y termino del gene. 
## Observation 4:
# This code block has low readability.
cat Winter.tsv | awk '{ if ($6 > 0) print $1" " $2" " $3" " $4" " $5" " $6}' | awk '{a[NR]=$0;b[$4]++;c[NR]=$4} END {for (i=1;i<=NR;i++) print a[i]"\t"b[c[i]]}' | awk '{a[$1" " $2" "$3" "$4" "$7]+=$6}END{for (i in a){print i,a[i]}}' | awk '{a=$3-$2+1;print $0,a;}' > R1.txt

#Aquí se realizan ambos cálculos para determinar el bcov y mdcov.
## Observation 5:
# This code block performs the calculations successfully.
# This line of code could have been integrated to work in the STDOUT of the preceding code block
awk '{ print $1, $2, $3, $4,( $5 / $7)*100, $6 / $5 }' R1.txt > R2.txt

#Esta linea es para comodidad elimino archivos temporales y ordeno el archivo
## Observation 6:
# This line ERASES all the work done so far.
rm R1.txt R2.txt Winter.tsv

## Observation 7:
# From here on any line of code is irrelevant since there is no intermediate data to work on.

#Inserto la linea para nombrar cada columna esto es mi archivo raw
sed -i '1i Chromosome Start End Locus_name Breadth_of_Coverage Depth_of_Coverage' Coverage_raw.txt

#Aquí obtenemos la tabl final con los datos solicitados de igual forma como se observa en el ejemplo de resultado en git. _:D Fue divertido 
awk '{print $4,$5,$6}' Coverage_raw.txt > Resume_Coverage.txt
