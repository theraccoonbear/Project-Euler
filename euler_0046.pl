#!/opt/local/bin/perl

# Project Euler Problem #46
#
# It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.
# 
# 9 = 7 + 2*1^(2)
# 15 = 7 + 2*2^(2)
# 21 = 3 + 2*3^(2)
# 25 = 7 + 2*3^(2)
# 27 = 19 + 2*2^(2)
# 33 = 31 + 2*1^(2)
# 
# It turns out that the conjecture was false.
# 
# What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';

#
# Code goes here...
#

my @primes = loadedPrimes('array');
my $prime;
my $last_prime;
my $msg = '';

for (my $n = 9; $n < 100000; $n += 2) {
  if (!isPrime($n)) {
    my $found = 0;
    for (my $i = 0; $i < scalar @primes; $i++) {
      my $prime = $primes[$i];
      for (my $nts = 1; $nts < $n; $nts++) {
        my $ppts = $prime + 2 * $nts ** 2;
        if ($ppts == $n) {
          $msg = "$n = $prime + 2 * $nts ^ 2";
          $found = 1;
          last;
        }
        tick($msg);
        if (2 * $nts ** 2 > $n) {
          last;
        }
      }
      if ($prime> $n) {
        last;
      }
    }
    if (!$found) {
      dbgMsg("Last Prime: $prime\n");
      $answer = $n;
      last;
    }
  }
}


print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 5777