#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# discover dotfiles repo directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# backup directory is relative and in .gitignore
BACKUP="$DIR/.backup"

# list of files/folders to symlink in homedir
FILES="vimrc latexmkrc psqlrc gitconfig"

##########

# create dotfiles_old in relative path
echo "Creating $BACKUP for backup of any existing dotfiles in ~"
mkdir -p $BACKUP
echo "...done"

# change to the dotfiles directory
echo "Changing to the $DIR directory"
cd $DIR
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for FILE in $FILES; do
    echo "Moving any existing dotfiles from ~ to $BACKUP"
    mv -f "$HOME/.$FILE" "$BACKUP/"
    echo "Creating symlink to $FILE in home directory."
    ln -s "$DIR/$FILE" "$HOME/.$FILE"
done
