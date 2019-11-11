#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';

use FindBin '$Bin';
use File::Path 'make_path';
use File::Copy 'move';
use Getopt::Long;

GetOptions(
  'verbose' => \my $verbose,
);

my $backup = "$Bin/.backup";

sub install {
  my $file = shift;
  my $as = shift || $file;

  my $source = "$Bin/$file";
  if (!-e $source) {
    die "Source file $source does not exist, bailing out!";
  }

  my $target = "$ENV{HOME}/.$as";
  if (-l $target) {
    my $link = readlink $target;
    if ($link eq $source) {
      say STDERR "Symlink already exists $target -> $source" if $verbose;
      return;
    }
    say STDERR "Replacing exsting link $target -> $link";
    unlink $target;
  } elsif (-f $target) {
    say STDERR "Backing up existing file $target to $backup";
    move $target, $backup or die "Backup failed: $!";
  }

  say STDERR "Creating link $target -> $source";
  symlink $source, $target or die "Could not link $target -> $source";
}

# new tmux config is required as of 2.9
sub is_new_tmux () {
  my $tmux = `tmux -V`;
  return undef unless $tmux;

  $tmux =~ s/tmux\s//;
  my @version = split /\./, $tmux;

  return 1 if $version[0] > 2;

  $version[1] =~ s/\D+$//; # strip trailing symbols
  return 1 if $version[1] >= 9;

  return 0;
}

sub main {
  if (! -d $backup) {
    say STDERR "Creating $backup for backup of any existing dotfiles in ~";
    make_path $backup or die "Error creating $backup: $!";
  }

  my @files = (qw[
    vimrc
    latexmkrc
    psqlrc
    gitconfig
    gitignore_global
    bash_aliases
    ssh/rc
    digrc
  ]);

  for my $file (@files) {
    install $file;
  }

  my $tmux = is_new_tmux ? 'tmux.new.conf' : 'tmux.old.conf';
  install $tmux => 'tmux.conf';
}

main();

