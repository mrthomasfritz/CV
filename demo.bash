#!/bin/bash

#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0
#0
#0 Demo Bash / Korn Shell Script by: 
#0		Thomas Fritz (210)560-0463
#0		Senior Linux Systems Eng.
#0		Copyright 2017-Apr-16, All Rights Reserved
#0 
#
Black=$(echo -e "\e[0;30m\c")
DarkGray=$(echo -e "\e[1;30m\c")
DarkRed=$(echo -e "\e[0;31m\c")
LightRed=$(echo -e "\e[1;31m\c")
DarkGreen=$(echo -e "\e[0;32m\c")
LightGreen=$(echo -e "\e[1;32m\c")
DarkYellow=$(echo -e "\e[0;33m\c")
LightYellow=$(echo -e "\e[1;33m\c")
DarkBlue=$(echo -e "\e[0;34m\c")
LightBlue=$(echo -e "\e[1;34m\c")
DarkPurple=$(echo -e "\e[0;35m\c")
LightPurple=$(echo -e "\e[1;35m\c")
DarkCyan=$(echo -e "\e[0;36m\c")
LightCyan=$(echo -e "\e[1;36m\c")
LightGray=$(echo -e "\e[0;37m\c")
White=$(echo -e "\e[1;37m\c")

##################################################################
# Display usage message if not called with any agruments
Usage () {
	echo -e "$LightRed\c"
	echo "Error, problems with arguments given to $0"
	echo -e "$DarkRed\c"
	egrep "^#0" <$0 | \
		sed	-e "s/#0/##/g" \
			-e "s/Thomas/${White}Thomas/g" \
			-e "s/$/${DarkRed}/g"
	echo -e "$White\n"
	exit -1
}

##################################################################
# Display either foo or bar... depending on remainders after modulus operator
#
FooBar () {
	MESSAGE=""
	ERR=""
	case ${2} in 
		'b')	MESSAGE="${LightGreen}Bar${White}"
			ERR=$(expr ${1} % ${Bar} |egrep -v "^0")
			;;
		'f') MESSAGE="${LightBlue}Foo${White}"
			ERR=$(expr ${1} % ${Foo} |egrep -v "^0")
			;;
		*) MESSAGE="${DarkRed}What is ${2}${White}";exit -1;;
	esac

	if [ -z "${ERR}" ] && [ -n "${MESSAGE}" ] ; then
		echo -e "${MESSAGE}\c"
	fi
}

##################################################################
# Routine: Count up
# Argument Current
# Return Current + 1
CountUp ()
	{

	if [ "${#}"  -eq "0" ] ; then
		echo No arguments 
		exit 
	else
		while :
		do
			if [ "$1" -le "${Stop}" ]
			then

				echo -e " ${1}\c"

				if [ -n "${Foo}" ] ; then
					FooBar ${1} f
				fi
				if [ -n "${Bar}" ] ; then
					FooBar ${1} b
				fi
				if [ -z "${Step}" ] ; then
					CountUp $(expr "${1}" + 1)
				else
					CountUp $( expr "${1}" + "${Step}" )
				fi

				# Yea... most people don't like to see the
				# top end counted twice.
				if [ "$1" -ne "${Stop}" ]
				then
					echo -e "${1}"
				fi
			fi
			break

		done
	fi
}


#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0#0
#0 Demo.bash:
#0 Argument ( start ) < stop > < step > < foo > < bar >
#0 start = the number which you would like to start to count from
#0 stop  = the number where you would like to stop counting to
#0 step  = count by how many numbers... 1, 2, 3, 4 would be one step at a time
#0 foo   = display foo when the number is not evenly divided by this number
#0       = results in a remainder number... 2.5 for example when you divide 
#0       = 5 by 2
#0 bar   = same as above

##################################################################
# Main
PROGRAM="${0}"


# filter garbage ( All letters and punctuation)
ARGS=$(echo ${*} |sed -e "s/[A-Z]//g" -e "s/[a-z]//g" -e "s/[!-\/]//g")
if [ ! -z "${ARGS}" ] ; then
	set ${ARGS}
	ARGS=${*}
fi

if [ "$#" -eq "0" ] ;then Usage  "${PROGRAM} Too Few Arguments" ; fi
if [ "$#" -ge "1" ] ;then Start=$1;shift ; fi
if [ "$#" -ge "1" ] ;then Stop=$1 ;shift; fi
if [ "$#" -ge "1" ] ;then Step=$1 ;shift; fi
if [ "$#" -ge "1" ] ;then Foo=$1  ;shift; fi
if [ "$#" -ge "1" ] ;then Bar=$1  ;shift; fi

# At this point, with the shifting, we should be zero on arguments on command
# line
if [ "$#" -ne "0" ] ;then 
		Usage "${PROGRAM} Too Many Arguments: ${ARGS}"
		exit 1
fi
echo -e $( CountUp ${Start} ${Stop} ${Step} ${Foo} ${Bar} ) "\n\n"


