#!/bin/bash
file="./texte.txt"
i=1
while read -r line
do
  nb=$(printf "%02d" "$i")
  convert -size 200X100 -gravity Center label:"$line" ligneimage_"${nb}".png
  i=$((i+1))
done < $file
convert -delay 50 ligneimage_*.png -loop 0 boule_de_neige.gif
rm ./ligneimage_*.png