#!/opt/local/bin/perl

# Project Euler Problem #25
#
# The Fibonacci sequence is defined by the recurrence relation:
# 
#     F_(n) = F_(n - 1) + F_(n - 2), where F_(1) = 1 and F_(2) = 1.
# 
# Hence the first 12 terms will be:
# 
#     F_(1) = 1
#     F_(2) = 1
#     F_(3) = 2
#     F_(4) = 3
#     F_(5) = 5
#     F_(6) = 8
#     F_(7) = 13
#     F_(8) = 21
#     F_(9) = 34
#     F_(10) = 55
#     F_(11) = 89
#     F_(12) = 144
# 
# The 12th term, F_(12), is the first term to contain three digits.
# 
# What is the first term in the Fibonacci sequence to contain 1000 digits?
# 


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

print "Timing started....\n\n";
startTiming();

debugOff();

my $fib = '';
my $i = 0;

while (length($fib) < 1000) {
  $i++;
  $fib = bigFib($i);
  print "$i) " . length($fib) . ", "  . $fib . "\n";
}

print "\n\nAnswer: $i\n\n";

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 4782