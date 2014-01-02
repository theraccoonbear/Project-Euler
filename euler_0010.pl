#!/opt/local/bin/perl

# Project Euler Problem #10
#
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
# Find the sum of all the primes below two million.


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

my $total = 0;
my $prime_cnt = 0;

for (my $x = 2; $x <= 2000000;  $x++) {
  if (isPrime($x)) {
    print ".";
    $total += $x;
    if (++$prime_cnt % 30 == 0) {
      print "\n";
    }
  }
}

print "\n\nTotal: $total\n\n";

# Answer: 