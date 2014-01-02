#!/opt/local/bin/perl

# Project Euler Problem #0
#
# Euler published the remarkable quadratic formula:
# 
# n^2 + n + 41
# 
# It turns out that the formula will produce 40 primes for the consecutive values n = 0 to 39. However, when n = 40, 40^(2) + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41^2 + 41 + 41 is clearly divisible by 41.
# 
# Using computers, the incredible formula  n^2 - 79n + 1601 was discovered, which produces 80 primes for the consecutive values n = 0 to 79. The product of the coefficients, -79 and 1601, is -126479.
# 
# Considering quadratics of the form:
# 
#     n^2 + an + b, where |a| < 1000 and |b| < 1000
# 
#     where |n| is the modulus/absolute value of n
#     e.g. |11| = 11 and |-4| = 4
# 
# Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.
# 


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

print "Timing started....\n\n";
startTiming();

my %PRIME_COUNTS;

my @PC;

print "\nFinding primes...\n";

sleep 1;

my $opc = 0;
my $lbc = 0;
my $xyz = 0;

my $big_a = 0;
my $big_b = 0;
my $big_prime_count = 0;

for (my $a = -1000; $a <= 1000; $a++) {
  
  print "$a / 1000\n";
  
  for (my $b = -1000; $b <= 1000;  $b++) {
    
    my $prime_found = 0;
    
    my $prime_count = 0;
    
    for (my $n = 0; $n <= 1000; $n++) {
      my $possible_prime = ($n ** 2) + ($a * $n) + $b;
      if ($possible_prime > 0) {
        if (isPrime($possible_prime)) {
          $prime_count++;
        } # is prime?
      } # pp > 0
    } # for (n)
    
    if ($prime_count > $big_prime_count) {
      $big_prime_count = $prime_count;
      $big_a = $a;
      $big_b = $b;
      
      print "(n ^ 2) + ($big_a * n) + $big_b = $big_prime_count\n";
    } # new big score?s
    
  } # for (b)
} # for (a)


my $answer = $big_a * $big_b;

print <<__ANSWER;

Longest Prime Run: $big_prime_count
"A" for Longest: $big_a
"B" for Longest: $big_b

(n ^ 2) + (n * $big_a) + $big_b = $big_prime_count

Answer: $answer

__ANSWER

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 