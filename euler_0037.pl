#!/opt/local/bin/perl

# Project Euler Problem #0
#
# The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and
# remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.
# 
# Find the sum of the only eleven primes that are both truncatable from left to right and right to left.
# 
# NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();

my $trunc_prime_cnt = 0;
my $answer = 0;
my $check = 9;

sub isTruncPrime($) {
  my $val = shift @_;
  
  for (my $i = 1; $i <= length($val); $i++) {
    if (isPrime(substr($val, 0, $i))) {
      if (!isPrime(substr($val, -$i, 100))) {
        return 0;
      }
    } else {
      return 0;
    }
  }
  
  return 1;
}

while ($trunc_prime_cnt < 11) {
  if (isTruncPrime($check)) {
    print "$check\n";
    $answer += $check;
    $trunc_prime_cnt++;
  }
  $check++;
}

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 748317