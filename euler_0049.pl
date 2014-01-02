#!/opt/local/bin/perl

# Project Euler Problem #49
#
# The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330, is unusual in two ways: (i) each of the three terms are
# prime, and, (ii) each of the 4-digit numbers are permutations of one another.
# 
# There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting this property, but there is one other 4-digit increasing sequence.
# 
# What 12-digit number do you form by concatenating the three terms in this sequence?
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';

my %seq_memo;

for (my $num = 1000; $num < 9999; $num++) {
  if (isPrime($num) && $num !~ m/^(1487|4817|8147)$/gi) {
    my $num2 = $num + 3330;
    if (isPrime($num2) && arePermutations($num, $num2)) {
      my $num3 = $num2 + 3330;
      if (isPrime($num3) && arePermutations($num2, $num3)) {
        $answer = $num . $num2 . $num3;
        last;
      }
    }
  }
}

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 296962999629