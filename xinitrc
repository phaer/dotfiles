#!/bin/sh


xrdb -merge $HOME/.Xdefaults
xset b off # disable audio bell
feh --bg-scale $HOME/.leben-heiszt-revolte.jpg
emacs --daemon

urxvt -title "shell" &
#emacsclient -c \
#    --frame-parameters="((name . \"Org\"))" \
#    --eval "(add-hook 'window-setup-hook 'delete-other-windows)
#            (org-agenda-list)(switch-to-buffer \"*Org Agenda*\")" &
chromium &
#icedove &
#keepass2 $HOME/Documents/keypasskdbx.kdbx &

#exec ck-launch-session xmonad
while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
  do
    sleep 1
  done &
exec ck-launch-session dwm

