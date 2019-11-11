#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use FindBin '$Bin';
use File::Path 'make_path';
use File::Copy 'move';

my $backup = "$Bin/.backup";

my @files = (qw[
  vimrc
  latexmkrc
  psqlrc
  gitconfig
  gitignore_global
  bash_aliases
  tmux.conf
  ssh/rc
  digrc
]);

if (! -d $backup) {
  say STDERR "Creating $backup for backup of any existing dotfiles in ~";
  make_path $backup or die "Error creating $backup: $!";
}

for my $file (@files) {
  my $source = "$Bin/$file";
  if (!-e $source) {
    die "Source file $source does not exist, bailing out!";
  }

  my $target = "$ENV{HOME}/.$file";
  if (-l $target) {
    my $link = readlink $target;
    if ($link eq $source) {
      say STDERR "Symlink already exists $target -> $source";
      next;
    }
    say STDERR "Replacing exsting link $target -> $link";
    unlink $target;
  } elsif (-f $target) {
    say STDERR "Backing up existing file $target to $backup";
    move $target, $backup or die "Backup failed: $!";
  }

  symlink $source, $target or die "Could not link $target -> $source";
}

