#!/opt/local/bin/perl

# Project Euler Problem #21
#
# Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
# If d(a) = b and d(b) = a, where a ­ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
# 
# For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
# 
# Evaluate the sum of all the amicable numbers under 10000.
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

#print sumArray(properDivisors(220)) . "\n"; exit 0;

startTiming();

my @memo = ();
my $sum = 0;
my $a_sum = 0;
my $b_sum = 0;

my %AMICABLE;

for (my $x = 1; $x < 10000; $x++) {
  
  if (defined $memo[$x]) {
    $a_sum = $memo[$x];
  } else {
    $a_sum = sumArray(properDivisors($x));
    $memo[$x] = $a_sum ;
  }
  
  if (defined $memo[$a_sum]) {
    $b_sum = $memo[$a_sum];
  } else {
    $b_sum = sumArray(properDivisors($a_sum));
    $memo[$a_sum] = $b_sum;
  }
  
  if ($x == $b_sum && $x != $a_sum) {
    #$sum += $x + $a_sum;
    $AMICABLE{$x} = 1;
    $AMICABLE{$a_sum} = 1;
  }
}

foreach my $key (sort keys %AMICABLE) {
  $sum += $key;
}
  

print "\n\nAnswer: $sum\n\n";

print "" . endTiming() . " second(s) elapsed.\n\n";

# Answer: 31626