#!/opt/local/bin/perl

# Project Euler Problem #38
#
# Take the number 192 and multiply it by each of 1, 2, and 3:
# 
#     192 * 1 = 192
#     192 * 2 = 384
#     192 * 3 = 576
# 
# By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)
# 
# The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).
# 
# What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1?
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer;
my $biggest_pandigital = 0;

for (my $n = 1; $n < 10000; $n++) {
  my $concat = '';
  #for (my $x = 1; $x < 10; $x++) {
  my $x = 1;
  
  while (length($concat) < 9) {
    $concat .= ($n * $x);
    
    if (length($concat) == 9) {
      if ($concat > $biggest_pandigital) {
        if (isPandigital($concat)) {
          print "$n * (" . join(', ', (1..$x)) . ") = $concat\n";
          $biggest_pandigital = $concat;
        }
      }
    }
    $x++;
  }
  
  
}

$answer = $biggest_pandigital;

print "\n\nAnswer: $answer\n\n";

endTiming();




# Answer: 932718654