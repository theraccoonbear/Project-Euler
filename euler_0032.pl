#!/opt/local/bin/perl

# Project Euler Problem #32
#
# We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; for
# example, the 5-digit number, 15234, is 1 through 5 pandigital.
# 
# The product 7254 is unusual, as the identity, 39 * 186 = 7254, containing multiplicand, multiplier, and
# product is 1 through 9 pandigital.
# 
# Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.
# HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.
# 


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output bufferingc
select((select(STDOUT), $|=1)[0]);

print "Timing started....\n\n";
startTiming();

my $answer = 0;
my %prod_memo;
my %str_memo;

for (my $x = 1; $x < 10000; $x++) {
  for (my $y = 1; $y < 10000; $y++) {
    my $total = $x * $y;
    my $str = $x . $y . $total;
    if (length($str) == 9 && !defined $prod_memo{$total}) {
      if (isPandigital($str)) {
        $prod_memo{$total} = 1;
        $answer += $total;
        print "$x * $y = $total\n";
      }
    } elsif (length($str) > 9) {
      last;
    }
  }
}

print "\n\nAnswer: $answer\n\n";

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 45228