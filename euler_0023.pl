#!/opt/local/bin/perl

# Project Euler Problem #23
#
# A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper
# divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
# 
# A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.
# 
# As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers
# is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers.
# However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be
# expressed as the sum of two abundant numbers is less than this limit.
# 
# Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
# 


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

print "Timing started....\n\n";
startTiming();

my @abundant = ();
my @perfect = ();
my @deficient = ();
my $def_cnt = 0;
my $per_cnt = 0;
my $abu_cnt = 0;

dbgMsg('Finding abundant numbers ...');

for (my $num = 1; $num <= 28123; $num++) {
  my @divisors = sort {$a <=> $b} properDivisors($num);
  my $sum = sumArray(@divisors);
  
  dbgMsg('.') unless ($num % 200);
  
  if ($sum == $num) {
    push @perfect, $num;
    $per_cnt++;
  } elsif ($sum < $num) {
    push @deficient, $num;
    $def_cnt++;
  } elsif ($sum > $num) {
    push @abundant, $num;
    $abu_cnt++;
  }
}

dbgMsg("\n\nCounts:\n");
dbgMsg("    Abundant: $abu_cnt\n");
dbgMsg("     Perfect: $per_cnt\n");
dbgMsg("   Deficient: $def_cnt\n\n");


dbgMsg("\n\nFinding all sums of two abundant numbers...");

my %SOA = ();

my $i = 0;

for (my $x = 0; $x <= $#abundant; $x++) {
  for (my $y = $x; $y <= $#abundant; $y++) {
    $SOA{$abundant[$x] + $abundant[$y]} = 1;
    if ($i++ % 15000 == 0) {
      dbgMsg('.');
    }
  }
  
}

dbgMsg("\n\nCount of abundant number sums: " . scalar(keys %SOA) . "\n");

dbgMsg("\nSumming numbers which cannot be defined as the sum of two abundant numbers...");

my $total = 0;
my $cnt = 0;

for (my $x = 0; $x < 28123; $x++) {
  if (!(defined $SOA{$x})) {
    $total += $x;
  }
  
  if ($cnt++ % 100 == 0) {
    dbgMsg('.');
  }
}

print "\n\nAnswer: $total\n\n";

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 4179871