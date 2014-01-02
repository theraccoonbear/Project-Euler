#!/opt/local/bin/perl

# Project Euler Problem #0
#
# Pentagonal numbers are generated by the formula, P(n)=n(3n-1)/2. The first ten pentagonal numbers are:
# 
# 1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...
# 
# It can be seen that P(4) + P(7) = 22 + 70 = 92 = P(8). However, their difference, 70 - 22 = 48, is not pentagonal.
# 
# Find the pair of pentagonal numbers, P(j) and P(k), for which their sum and difference is pentagonal and D = |P(k) - P(j)| is minimised; what is the value of D?
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';


my @pent_memo;
my %pent_vals;
my $max = 3000;
my $small_value = 100000000000000;

for my $val ((1..$max)) {
  $pent_memo[$val] = pentNum($val);
  $pent_vals{$pent_memo[$val]}++;
}

for (my $j = 1; $j < $max; $j++) {
  my $j_val = $pent_memo[$j];
  for (my $k = 1; $k < $max; $k++) {
    my $k_val = $pent_memo[$k];  
    if (defined $pent_vals{$j_val + $k_val} && defined $pent_vals{max($j_val, $k_val) - min($j_val, $k_val)}) {
      if (abs($j_val - $k_val) < $small_value) {
        print "\nJ: $j [$j_val], K: $k [$k_val] = " . abs($j_val - $k_val) . "\n";
        $small_value = abs($j_val - $k_val);
      }
    }
  }
  if ($j % 100 == 0) { tick("Current Smallest: $small_value"); }
}

$answer = $small_value;


print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 5482660