#!/opt/local/bin/perl

# Project Euler Problem #7
#
# By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
# 
# What is the 10001st prime number?


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

print "Finding primes... ";

my $prime_cnt = 0;

for (my $x = 2; $x < 1000000; $x++) {
  if (isPrime($x)) {
    print "$x, ";
    $prime_cnt++;
    if ($prime_cnt == 10001) {
      print "\n\n10001st Prime: $x\n";
      exit 0;
    }
    if ($prime_cnt % 10 == 0) {
      print "\n";
    }
  }
}

# Answer: 