#!/opt/local/bin/perl

# Project Euler Problem #47
#
# The first two consecutive numbers to have two distinct prime factors are:
# 
# 14 = 2 * 7
# 15 = 3 * 5
# 
# The first three consecutive numbers to have three distinct prime factors are:
# 
# 644 = 2^2 * 7 * 23
# 645 = 3 * 5 * 43
# 646 = 2 * 17 * 19.
# 
# Find the first four consecutive integers to have four distinct primes factors. What is the first of these numbers?
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';
my @factors;
my $cnt = 0;
my $target = 4;
my $num = 646;

while (1) {
  @factors = @{primeFactorization($num)};
  my %df;
  map {$df{$_}++} @factors;
 
  #dbgMsg("Prime factors of $num = " . join(' * ', @factors) . " [dpf: " . (scalar keys %df) . ", run length: $cnt]\n");
  
  if (scalar keys %df == $target) {
    $cnt++;
    
    if ($cnt > 2) {
      dbgMsg("Prime factors of $num = " . join(' * ', @factors) . " [dpf: " . (scalar keys %df) . ", run length: $cnt]\n");
    }
    
    if ($cnt == $target) {
      $answer = $num - $target + 1; 
      last;
    }
  } else {
    $cnt = 0;
  }
  $num++;
}

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 