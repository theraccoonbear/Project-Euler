#!/opt/local/bin/perl

# Project Euler Problem #57
# It is possible to show that the square root of two can be expressed as an infinite continued fraction.
# 
# Ã 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
# 
# By expanding this for the first four iterations, we get:
# 
# 1 + 1/2 = 3/2 = 1.5
# 1 + 1/(2 + 1/2) = 7/5 = 1.4
# 1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
# 1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
# 
# The next three expansions are 99/70, 239/169, and 577/408, but the eighth expansion, 1393/985, is the first example
# where the number of digits in the numerator exceeds the number of digits in the denominator.
# 
# In the first one-thousand expansions, how many fractions contain a numerator with more digits than denominator?
#
use bignum(p => -1000);
use strict;
use warnings;
require "functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = 0;

my $num = 3;
my $denom = 2;
my $new_num = 1;
my $new_denom = 2;

for ((1..1000)) {
  print "$num / $denom\n";
  if (length($num) > length($denom)) {
    $answer++;
  }
  $new_denom = $denom + $num;
  $new_num = $denom + $new_denom;
  $num = $new_num;
  $denom = $new_denom;
}

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 153