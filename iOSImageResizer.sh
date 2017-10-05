#!/bin/sh          

imageWidth=1
imageHeight=1

rWidth=1
rHeight=1

# $1 - width $2 - height $3 - file
resizeImage() {

	echo "Resize image file name - " "$3"

	sips -z $2 $1 "$3"
}

showSizes() {

	echo $rWidth $rHeight
}

resize () {

	originalFileName=$1
	cleanName=$(echo $1 | cut -f 1 -d '.')

	echo $originalFileName

	x1ImageName="$cleanName.png"
	x2ImageName="$cleanName@2x.png"
	x3ImageName="$cleanName@3x.png"

    cp "$originalFileName" "$x2ImageName"
    cp "$originalFileName" "$x3ImageName"


	getSize "$1"

	resizeX1
	resizeImage $rWidth $rHeight "$x1ImageName"

	resizeX2
	resizeImage $rWidth $rHeight "$x2ImageName"

}


getSize() {

	imageHeight=$(sips -g pixelHeight "$1" | tail -n1 | cut -d" " -f4)
	imageWidth=$(sips -g pixelWidth "$1" | tail -n1 | cut -d" " -f4)
}


resizeX2() {

	rWidth=$(($imageWidth/3*2))
	rHeight=$(($imageHeight/3*2))
}


resizeX1() {

	rWidth=$(($imageWidth/3))
	rHeight=$(($imageHeight/3))
}



for filename in *.png; do
	resize "$filename"
done

