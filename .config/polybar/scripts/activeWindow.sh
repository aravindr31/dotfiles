
#!/bin/bash

WM_DESKTOP=$(xdotool getwindowfocus getwindowclassname)

#echo $WM_DESKTOP

#WM_CLASS=$(xprop -id $(xdotool getactivewindow) WM_CLASS | awk 'NF {print $NF}' | sed 's/"/ /g')
#WM_NAME=$(xdotool getactivewindow getwindowclassname)

tc() { set ${*,,} ; echo ${*^} ; }

TCC() {
  sed 's/.*/\L&/; s/[a-z]*/\u&/g' <<<"$1"    
}


#xprop -id $(xdotool getactivewindow) WM_ClASS | cut -d "," -f 2 | tr -d '"'

if [[ $WM_DESKTOP == 'Subl' ]]; then
    echo "Sublime Text"
else    
    echo ${WM_DESKTOP^}

fi
