grep 'more<' index.html > jump.txt
sort -u -o jump.txt jump.txt
noLines=$(wc -l < jump.txt)
for i in $(seq 1 $((noLines)));
do
  link="$(sed -n "${i}p" jump.txt)"
  link=${link// }
  link=${link%% }
  starti="$(echo $link | grep -aob / | grep -oE '[0-9]+' | sed "2q;d")"
	endi="$(echo $link | grep -aob '/' | grep -oE '[0-9]+' | sed "3q;d")"
  length=$((endi-starti))
	output=${link:$((starti+1)):$((length-1))}
  starti="$(echo $link | grep -aob '"' | grep -oE '[0-9]+' | sed "1q;d")"
	endi="$(echo $link | grep -aob '"' | grep -oE '[0-9]+' | sed "2q;d")"
  length=$((endi-starti))
	link2=${link:$((starti+1)):$((length-1))}
  page="www.hackerearth.com$link2"
  wget -O $output.html $page
  html2pdf $output.html $output.pdf
#  gnome-open $output.pdf
  rm $output.html
done
