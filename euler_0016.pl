#!/opt/local/bin/perl

# Project Euler Problem #16
#
# 2^(15) = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
#
# What is the sum of the digits of the number 2^(1000)?



use strict;
use warnings;
use List::Util qw[min max];

require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

debugOff();

my $answer = bigExp('2','1000');
my $sum = 0;

for (my $i = 0; $i < length($answer); $i++) {
  $sum += int(substr($answer, $i, 1));
}

print "\n\n2 ^ 1000 = " . $answer . "\n";
print "\n\nAnswer: $sum\n\n";


# Answer: 1366