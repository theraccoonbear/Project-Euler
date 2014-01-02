#!/opt/local/bin/perl

# Project Euler Problem #20
#
# n! means n * (n - 1) * ... * 3 * 2 * 1
#
# Find the sum of the digits in the number 100!
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

debugOff();
my $fac_result = bigFac(100);
my $result = 0;

for (my $i = 0; $i < length($fac_result); $i++) {
  $result += int(substr($fac_result, $i, 1));
}

print "\n\n100! = $fac_result\n\n";
print "\n\nAnswer: $result\n\n";

# Answer: 648