#!/opt/local/bin/perl

# Project Euler Problem #39
#
# If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.
# 
# {20,48,52}, {24,45,51}, {30,40,50}
# 
# For which value of p ² 1000, is the number of solutions maximised?
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer;

my $target = 1000;
my $p;
my $a;
my $b;
my $c;
my %counts;



for ($p = 1; $p < $target; $p++) {
  for ($a = 1; $a < $p; $a++) {
    for ($b = 1; $b < $p; $b++) {
      $c = sqrt($a**2 + $b**2);
      
      if ($c == int($c) && $a + $b + $c == $p) {
        print "$a -> $b -> $c == $p\n";
        $counts{$p}++;
      }
    }
  }
}

my $big = 0;
my $big_p = 0;
map {if ($counts{$_} > $big) { $big = $counts{$_}; $big_p = $_; }} keys %counts;

$answer = "$big_p = $big";

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 840