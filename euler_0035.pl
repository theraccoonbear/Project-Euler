#!/opt/local/bin/perl

# Project Euler Problem #35
#
# The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.
# 
# There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
# 
# How many circular primes are there below one million?
# 


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

print "Timing started....\n\n";
startTiming();



my $all_prime = 1;
my $prime_count = 0;

for (my $x = 2; $x < 1000000; $x++) {
  $all_prime = 1;
  
  for (my $os = 0; $os < length($x); $os++) {
    my $check_val = substr($x, $os, length($x) - $os) . substr($x, 0, $os);
    if (!isPrime($check_val)) {
      $all_prime = 0;
      last;
    }
  }
  
  if ($all_prime) {
    print "$x\n";
    $prime_count++;
  }
}

print "\n\nAnswer: $prime_count\n\n";

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";

# Answer: 55