#!/bin/bash

red=$(tput bold;tput setaf 1)            
green=$(tput setaf 2)                    
yellow=$(tput bold;tput setaf 3)         
fawn=$(tput setaf 3)
blue=$(tput bold;tput setaf 4)           
purple=$(tput setaf 5)
pink=$(tput bold;tput setaf 5)           
cyan=$(tput bold;tput setaf 6)           
gray=$(tput setaf 7)                     
white=$(tput bold;tput setaf 7)          
normal=$(tput sgr0)                      

sep=`echo -e '\001'` # use \001 as a separator instead of '/'

while [ -n "$1" ] ; do
  color=${!1}
  pattern="$2"
  shift 2

  rules="$rules;s$sep\($pattern\)$sep$color\1$normal${sep}g"
done

#stdbuf -o0 -i0 sed -u -e "$rules"
sed -u -e "$rules"

