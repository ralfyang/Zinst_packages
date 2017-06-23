#!/bin/bash

#BaseRoot=`cat /usr/bin/zinst |grep "ZinstBaseRoot=" | awk -F'=' '{print $2}' | sed -s 's/"//g'`
#WorkDIR=$BaseRoot/dist
os_arry=(rhel ubuntu rhel7)
CurrentDir=$PWD

for i in ${os_arry[@]}
do
	WorkDIR=$CurrentDir/$i
	mkdir -p $WorkDIR/checker 2> /dev/null
	ListUpArry=( `ls $WorkDIR |grep ".zinst"` )
	Count=0
		while [ $Count -lt ${#ListUpArry[@]} ] 
		do
			cd $WorkDIR/checker
			OrgName=`echo "${ListUpArry[$Count]}" | awk -F '-' '{print $1}'`
			Zicf_name=`tar tfv $WorkDIR/${ListUpArry[$Count]} | awk '{print $NF}' |grep "\.zicf" |head -1`
			tar zxvfp $WorkDIR/${ListUpArry[$Count]} $Zicf_name && mv $Zicf_name  $WorkDIR/checker/ 2> /dev/null
			mv $WorkDIR/checker/$Zicf_name $WorkDIR/checker/${ListUpArry[$Count]}.zicf
		let Count=$Count+1
		done
	
	sudo chmod -R 775  $WorkDIR/*
	sudo chgrp -R wheel $WorkDIR/*
done
