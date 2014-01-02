#!/opt/local/bin/perl

# Project Euler Problem #56
# A googol (10^(100)) is a massive number: one followed by one-hundred zeros; 100^(100) is almost unimaginably large: one followed
# by two-hundred zeros. Despite their size, the sum of the digits in each number is only 1.
# 
# Considering natural numbers of the form, a^(b), where a, b < 100, what is the maximum digital sum?
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";
use Math::BigInt;

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';

my $biggest = 0;
my $exp; #= BigInt->new();


sub sumDigits($) {
  my $n = shift @_;
  my $t = 0;
  
  for (my $i = 0; $i < length($n); $i++) {
    $t += substr($n, $i, 1);
  }
  
  return $t;
} # sumDigits()

#debugOff();

for my $a ((1..99)) {
  for my $b ((1..99)) {
    my $ba = new Math::BigInt $a;
    my $bb = new Math::BigInt $b;
    $exp = $ba->bpow($bb);;
    my $sum = sumDigits($exp);
    if ($sum > $biggest) {
      tick("$a ^ $b = $exp, digital sum = $sum");
      $biggest = $sum;
    }
    if ($b == 1) {
      tick("$a ^ $b biggest = $biggest");
    }
  }
}

$answer = $biggest;

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 972