#!/opt/local/bin/perl

# Project Euler Problem #34
#
# 145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
# 
# Find the sum of all numbers which are equal to the sum of the factorial of their digits.
# 
# Note: as 1! = 1 and 2! = 2 are not sums they are not included.
# 


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

print "Timing started....\n\n";
startTiming();

for (my $x = 3; $x < 100000; $x++) {
  my $total = 0;  
  foreach my $digit (split(//, $x)) {
    $total += factorial($digit);
  }
  
  if ($total == $x) {
    print "\n$x\n";
  }
  
  
  if ($x % 10000 == 0) { print '.'; }
  
}

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 40730