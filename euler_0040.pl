#!/opt/local/bin/perl

# Project Euler Problem #0
#
# An irrational decimal fraction is created by concatenating the positive integers:
# 
# 0.123456789101112131415161718192021...
# 
# It can be seen that the 12^(th) digit of the fractional part is 1.
# 
# If d_(n) represents the n^(th) digit of the fractional part, find the value of the following expression.
# 
# d_(1) * d_(10) * d_(100) * d_(1000) * d_(10000) * d_(100000) * d_(1000000)
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';
my $num = 1;

my $irr_dec = '';
while (length($irr_dec) < 1000000) {
  $irr_dec .= ($num++);
}

$answer = substr($irr_dec, 0, 1) * substr($irr_dec, 99, 1) * substr($irr_dec, 999, 1) * substr($irr_dec, 9999, 1) * substr($irr_dec, 99999, 1) * substr($irr_dec, 999999, 1);

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 410