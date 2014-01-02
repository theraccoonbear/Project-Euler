#!/opt/local/bin/perl

# Project Euler Problem #28
#
# Starting with the number 1 and moving to the right in a clockwise direction a 5 by 5 spiral is formed as follows:
# 
# *21* 22  23  24 *25*
#  20  *7*  8  *9* 10
#  19   6  *1*  2  11
#  18  *5*  4  *3* 12
# *17* 16  15  14 *13*
# 
# It can be verified that the sum of the numbers on the diagonals is 101.
# 
# What is the sum of the numbers on the diagonals in a 1001 by 1001 spiral formed in the same way?
# 


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

my $next_corner = 1;
my $inc = 2;
my $total = 1;
my $grid_dim = 1001;

for (my $x = 3; $x <= $grid_dim; $x += 2) {
  
  for ((1..4)) {
    $next_corner += $inc;
    $total += $next_corner;
  }
  
  print "\n$x x $x : $total\n";
  $inc += 2;
}

print "\n\n$grid_dim x $grid_dim = $total\n\n";

print "Timing started....\n\n";
startTiming();

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 669171001