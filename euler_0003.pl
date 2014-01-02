#!/opt/local/bin/perl

# Project Euler Problem #3
#
# The prime factors of 13195 are 5, 7, 13 and 29.
#
# What is the largest prime factor of the number 600851475143 ?
#

use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);


my $magic = 600851475143;
my $sqrt_magic = sqrt $magic;
my $largest = 0;

for (my $x = 3; $x < $sqrt_magic; $x++) {
  if (isPrime($x)) {
    if ($magic % $x == 0) {
      print "$x, ";
      $largest = $x;
    }
  }
}


print "\n\nLargest: $largest\n\n";



# Answer: 6857