#!/opt/local/bin/perl

# Project Euler Problem #5
#
# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
#
# What is the smallest number that is evenly divisible by all of the numbers from 1 to 20?
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";


# Disable output buffering
select((select(STDOUT), $|=1)[0]);

my @small_primes = (2,3,5,7,11,13,17,19);

my $total = 1;
my @pf;
my $div_cnt = 0;
my @for_lcm = (1..20);

# Iterate through each of the primes
for my $prime (@small_primes) {
  print "\nCHECKING PRIME: $prime\n";
  do { # do this as long as one of our numbers can be factored by this prime
    $div_cnt = 0;
    for (my $i = 0; $i < scalar(@for_lcm); $i++) {
      my $padded = sprintf("%*s", 5, $for_lcm[$i]); # formatting
      
      if ($for_lcm[$i] % $prime == 0) {
        
        print $padded . ' factored by ' . $prime . " to " . ($for_lcm[$i] / $prime) . "\n";
        $div_cnt++;
        $for_lcm[$i] /= $prime;
      } else {
        print $padded . " not factorable\n";
      }
    }
    
    
    if ($div_cnt > 0) {
      print "\n ...again...\n\n";
      push @pf, $prime;
    } else {
      print $prime . " COMPLETED\n";
    }
    
  } while $div_cnt != 0;
}

($total *= $_) for @pf; 

print "\nFactors: " . join(', ', @pf) . "\n";

print "\nAnswer: $total\n\n";


# Answer: 232792560