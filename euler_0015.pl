#!/opt/local/bin/perl

# Project Euler Problem #15
#
# Starting in the top left corner of a 2x2 grid, there are 6 routes (without backtracking) to the bottom right corner.
#
#    http://projecteuler.net/project/images/p_015.gif
#
# How many routes are there through a 20x20 grid?
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

sub pathsFromHere($$);

my $x = 0;
my $y = 0;

my $grid = 21;

my $grid_width = $grid;
my $grid_height = $grid;

my $call_depth = 0;

my %memo = ();

sub pathsFromHere($$) {
  my $lx = shift @_;
  my $ly = shift @_;
  my $cnt = 0;
  
  $call_depth++;
  
  if (defined $memo{$lx . ',' . $ly}) {
    dbgMsg("Cache hit for $lx, $ly\n");
    return $memo{$lx . ',' . $ly};
  }
  
  my $padding = $call_depth;
  
  if ($lx < $grid_width) {
    $cnt += pathsFromHere($lx + 1, $ly);
  }
  
  if ($ly < $grid_height) {
    $cnt += pathsFromHere($lx, $ly + 1);
  }
  
  if ($lx == $grid_width && $ly == $grid_height) {
    $cnt++;
  }
  
  $call_depth--;
  
  dbgMsg("Caching $cnt paths for $lx, $ly\n");
  $memo{$lx . ',' . $ly} = $cnt;
  return $cnt;
}


print "\n\nPaths from (1,1): " . pathsFromHere(1,1) . "\n\n"; 


# Answer: 137846528820