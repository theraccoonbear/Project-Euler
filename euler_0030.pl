#!/opt/local/bin/perl

# Project Euler Problem #30
#
# Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:
# 
#     1634 = 1^(4) + 6^(4) + 3^(4) + 4^(4)
#     8208 = 8^(4) + 2^(4) + 0^(4) + 8^(4)
#     9474 = 9^(4) + 4^(4) + 7^(4) + 4^(4)
# 
# As 1 = 1^(4) is not a sum it is not included.
# 
# The sum of these numbers is 1634 + 8208 + 9474 = 19316.
# 
# Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.
# 


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

print "Timing started....\n\n";
startTiming();

my $total = 0;

for (my $i = 2; $i < 1000000; $i++) {
  my @digits = split(//, $i);
  my $sum = 0;
  my $sr = '';
  foreach my $d (@digits) {
    $sum += $d ** 5;
    $sr .= ($sr eq '' ? '' : ' + ') . "($d ^ 5)";
  }
  if ($sum == $i) {
    print "$i = $sr\n";
    $total += $sum;
  }
}

print "\n\nAnswer: $total\n\n";

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 443839