#!/opt/local/bin/perl

# Project Euler Problem #48
#
# The series, 1^(1) + 2^(2) + 3^(3) + ... + 10^(10) = 10405071317.
#
# Find the last ten digits of the series, 1^(1) + 2^(2) + 3^(3) + ... + 1000^(1000).
#
use strict;
use warnings;
use bignum(p => -100000);
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';
my $rt = 0;

debugOff();

foreach (my $n = 1; $n <= 1000; $n++) {
  my $exp = ($n ** $n);
  # need to modify bigAdd to only add the 10 rightmost digits
  $rt = bigAdd($rt, $exp);
  if ($n % 10 == 0) { tick("$n --- " . substr($rt, -10, 10)); }
}


print "$rt\n";

$answer = substr($rt, -10, 10);

print "\n\nAnswer: $answer\n\n";

endTiming();

# Answer: 9110846700