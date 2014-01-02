#!/opt/local/bin/perl

# Project Euler Problem #6
#
# The sum of the squares of the first ten natural numbers is,
# 1^(2) + 2^(2) + ... + 10^(2) = 385
# 
# The square of the sum of the first ten natural numbers is,
# (1 + 2 + ... + 10)^(2) = 55^(2) = 3025
# 
# Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 ? 385 = 2640.
# 
# Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

my $x = 0;
my $sum_of_squares = 0;
my $square_of_sums = 0;
my $diff = 0;

for (my $x = 1; $x <= 100; $x++) {
  $sum_of_squares += ($x ** 2);
  $square_of_sums += $x;
}
$square_of_sums = $square_of_sums ** 2;

$diff = $square_of_sums - $sum_of_squares;

print <<__ANSWER;

Sum of Squares: $sum_of_squares
Square of Sums: $square_of_sums
Difference: $diff

__ANSWER

# Answer: 25164150