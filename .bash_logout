# ~/.bash_logout: executed by bash(1) when login shell exits.

if [ "$(ps hxo pid:1,stat:1,tty:1 | grep pts/ | grep "s " | wc -l)" == "1" ]; then
	# end weasel-pageant
	ps -C helper.exe -o pid --no-headers | xargs kill
	ps -C weasel-pageant -o pid --no-headers | xargs kill

	# end powerline daemon
	ps -C powerline-daemon -o pid --no-headers | xargs kill
fi

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
