mkdir ~/.makesymback


backupAndLink(){
	mv ~/$1  ~/.makesymback/$1
	ln -s "$(readlink -f ./$2/$1)" ~/$1
}

backupAndLink ".emacs"  "emacs"
backupAndLink ".emacs.d" "emacs"
backupAndLink ".bash_profile" "bash"
backupAndLink ".bashrc" "bash"
backupAndLink ".bashrc_mac" "bash"
backupAndLink ".bash_aliases" "bash"
backupAndLink ".bash_aliases_mac" "bash"


#mv ~/.emacs ~/.makesymback/.emacs
#ln -s "$(readlink -f ./emacs/.emacs)" ~/.emacs

#mv ~/.emacs.d ~/.makesymback/.emacs.d
#ln -s "$(readlink -f ./emacs/.emacs.d)" ~/.emacs.d

#ln -s "$(readlink -f ./bash/.bash_profile)"  ~/.bash_profile

#ln -s "$(readlink -f ./bash/.bashrc)"  ~/.bashrc

#ln -s "$(readlink -f ./bash/.bashrc_mac)"  ~/.bashrc_mac

#ln -s "$(readlink -f ./bash/.bash_aliases)"  ~/.bash_aliases

#ln -s "$(readlink -f ./bash/.bash_aliases_mac)"  ~/.bash_aliases_mac
