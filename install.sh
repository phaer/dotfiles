for f in `ls`
do
	if [ $f != "install.sh" ]
	then
		echo "installing \"$f\" to \"$HOME/.$f\"... "
		ln -s `pwd`/$f $HOME/.$f
	fi
done
