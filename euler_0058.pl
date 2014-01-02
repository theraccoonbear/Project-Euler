#!/opt/local/bin/perl

# Project Euler Problem #58
# Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.
# 
# 37 36 35 34 33 32 31
# 38 17 16 15 14 13 30
# 39 18  5  4  3 12 29
# 40 19  6  1  2 11 28
# 41 20  7  8  9 10 27
# 42 21 22 23 24 25 26
# 43 44 45 46 47 48 49
# 
# It is interesting to note that the odd squares lie along the bottom right diagonal, but what is more interesting is
# that 8 out of the 13 numbers lying along both diagonals are prime; that is, a ratio of 8/13 Å 62%.
# 
# If one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed.
# If this process is continued, what is the side length of the square spiral for which the ratio of primes along both
# diagonals first falls below 10%?
# 
use strict;
use warnings;
require "functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';

my $next_corner = 1;
my $inc = 0;
my $total = 1;

my $prime_cnt = 0;
my $non_prime_cnt = 0;
my $percentage = 1;
my $itr = 1;
my @corners = ();

while ($percentage > 0.1) {
  
  $inc += 2;
  
  @corners = ();
  for ((1..4)) {
    $next_corner += $inc;
    push @corners, $next_corner;
    if (isPrime($next_corner)) {
      $prime_cnt++;
    }
    $total++;
  }
  
  $percentage = $prime_cnt / $total;
  
  $answer = $inc + 1;
  
  dbgMsg($itr++ . ") [$answer x $answer] $prime_cnt / $total = $percentage -- " . join(', ', @corners) ."\n");
  
  
}

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 26241