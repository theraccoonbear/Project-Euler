#!/opt/local/bin/perl

# Project Euler Problem #52
#
# It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.
#
# Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';

my $num = 0;
my $fancy = 0;

while (!$fancy) {
  $num++;
  $fancy = (arePermutations($num, $num * 2) && arePermutations($num, $num * 3) && arePermutations($num, $num * 4) && arePermutations($num, $num * 5) && arePermutations($num, $num * 6))
}

$answer = $num;

print "\n\nAnswer: $answer\n\n";

endTiming();

# Answer: 142857