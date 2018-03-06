sed '1d' raw_coverages_by_base.tsv > Winter.tsv  #Elimino la primera fila para comodidad
cat Winter.tsv | awk '{ if ($6 > 0) print $1" " $2" " $3" " $4" " $5" " $6}'| awk '{a[NR]=$0;b[$4]++;c[NR]=$4} END {for (i=1;i<=NR;i++) print a[i]"\t"b[c[i]]}' | awk '{a[$1" " $2" "$3" "$4" "$7]+=$6}END{for (i in a){print i,a[i]}}' | awk '{a=$3-$2;print $0,a;}' > R1.txt  # En esta linea es eliminar u omitir las lineas donde el campo Depth_by_base sea cero posterior a esto se va contando cuantas veces se encuentra el dato en genes y a la par suma los datos en depth_by_base en cada categoría (gene) y termina calculando la diferencia entre el inicio y termino del gene. 
awk '{ print $1, $2, $3, $4,( $5 / $7)*100, $6 / $5 }' R1.txt > R2.txt  #Aquí se realizan ambos cálculos para determinar el coverage de acuerdo a lo explicado en git. 
cat R2.txt | sort -k 4 > Coverage_raw.txt
rm R1.txt R2.txt Winter.tsv #Esta linea es para comodidad elimino archivos temporales y ordeno el archivo
sed -i '1i Chromosome Start End Locus_name Breadth_of_Coverage Depth_of_Coverage' Coverage_raw.txt #Inserto la linea para nombrar cada columna esto es mi archivo raw
awk '{print $4,$5,$6}' Coverage_raw.txt > Resume_Coverage.txt  #Aquí obtenemos la tabl final con los datos solicitados de igual forma como se observa en el ejemplo de resultado en git. _:D Fue divertido 







