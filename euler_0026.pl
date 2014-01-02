#!/opt/local/bin/perl

# Project Euler Problem #26
#
# A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:
# 
#     ^(1)/_(2)	= 	0.5
#     ^(1)/_(3)	= 	0.(3)
#     ^(1)/_(4)	= 	0.25
#     ^(1)/_(5)	= 	0.2
#     ^(1)/_(6)	= 	0.1(6)
#     ^(1)/_(7)	= 	0.(142857)
#     ^(1)/_(8)	= 	0.125
#     ^(1)/_(9)	= 	0.(1)
#     ^(1)/_(10)	= 	0.1
# 
# Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that ^(1)/_(7) has a 6-digit recurring cycle.
# 
# Find the value of d < 1000 for which ^(1)/_(d) contains the longest recurring cycle in its decimal fraction part.
# 


use strict;
use warnings;
use bignum (p => -10000);
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

print "Timing started....\n\n";
startTiming();

my $biggest = '';
my $biggest_unit = 0;

for (my $x = 1; $x < 1000; $x++) {
  my $unit_frac = (1 * 10 ** 100) / $x;
  (my $inspec =  $unit_frac) =~ s/^[^\.]+.(.+)$/$1/gi;
  
  if ($inspec =~ m/^(\d+?)\1/gi ) {
    my $cycle = $1;
    if (length($cycle) > length($biggest)) {
      $biggest = $cycle;
      $biggest_unit = $x;
      print "1 / $x = $cycle (" . length($cycle) . ")\n\n$unit_frac\n\n";
    }
  }
}

rule();

print "\nAnswer: $biggest_unit\n\n";
print "1 / $biggest_unit = " . (1 / $biggest_unit) . "\n\nCycle: (" . length($biggest) .  ") $biggest";

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 