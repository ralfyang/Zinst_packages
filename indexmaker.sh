#!/bin/bash

#BaseRoot=`cat /usr/bin/zinst |grep "ZinstBaseRoot=" | awk -F'=' '{print $2}' | sed -s 's/"//g'`
#WorkDIR=$BaseRoot/dist
WorkDIR=$PWD

mkdir -p $WorkDIR/checker 2> /dev/null
ListUpArry=( `ls $WorkDIR |grep ".zinst"` )
Count=0

	while [ $Count -lt ${#ListUpArry[@]} ] 
	do
		cd $WorkDIR/checker
		OrgName=`echo "${ListUpArry[$Count]}" | awk -F '-' '{print $1}'`
		tar zxvfp $WorkDIR/${ListUpArry[$Count]} $OrgName.zicf -C $WorkDIR/checker
		mv $WorkDIR/checker/$OrgName.zicf $WorkDIR/checker/${ListUpArry[$Count]}.zicf
	let Count=$Count+1
	done

sudo chmod 775 -R $WorkDIR/*
sudo chgrp wheel -R $WorkDIR/*
