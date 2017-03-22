#! /bin/sh
cd "$(dirname "$0")"
songChoice=$(cat songChoice.save)
[[ -z $songChoice ]] && songChoice=0
file="songs/$(ls -1 songs | head -$((songChoice + 1)) | tail -1)"
#if [[ $songChoice == "1" ]]; then
#	file=stillAliveLyrics
#else
#	file=wantYouGoneLyrics
#fi
lineNum=$(cat linenum.save)
[[ -z $lineNum ]] && lineNum=1
if [[ $lineNum -gt $(wc -l < $file) ]]; then
	lineNum=1
	songAmount=$(ls -1 songs | wc -l)
	songChoice=$(((songChoice + 1) % songAmount))
	file="songs/$(ls -1 songs | head -$((songChoice + 1)) | tail -1)"
	echo $songChoice > songChoice.save; 
	echo 1 > linenum.save; 
fi

echo $(($lineNum+1)) > linenum.save
awk "NR==$lineNum" $file
