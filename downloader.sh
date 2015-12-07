grep 'more<' index.html | uniq | 
while read -r link
do
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
  echo $output
  wget -o log.txt -O $output.html $page
  html2pdf $output.html $output.pdf
  rm $output.html
done
rm log.txt
