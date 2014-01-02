#!/opt/local/bin/perl

# Project Euler Problem #9
#
# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
# a^(2) + b^(2) = c^(2)
# 
# For example, 3^(2) + 4^(2) = 9 + 16 = 25 = 5^(2).
# 
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

for (my $a = 1; $a < 1000; $a++) {
  for (my $b = 1; $b < 1000; $b++) {
    my $c = sqrt($a ** 2 + $b ** 2);
    if ($a + $b + $c == 1000) {
      print "\n\nA: $a\nB: $b\nC: $c\nProduct: " . ($a * $b * $c) . "\n\n";
    }
  }
}

# A: 200
# B: 375
# C: 425
# Answer: 31875000