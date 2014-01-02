#!/opt/local/bin/perl

# Project Euler Problem #53
# There are exactly ten ways of selecting three from five, 12345:
# 
# 123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
# 
# In combinatorics, we use the notation, ^(5)C_(3) = 10.
# 
# In general,
# ^(n)C_(r) = 	
# n!
# r!(n-r)!
# 	,where r ² n, n! = n * (n - 1) * ...  * 3  * 2 * 1, and 0! = 1.
# 
# It is not until n = 23, that a value exceeds one-million: ^(23)C_(10) = 1144066.
# 
# How many, not necessarily distinct, values of  ^(n)C_(r), for 1 ² n ² 100, are greater than one-million?
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = 0;

sub selectionCombos($$) {
  my $n = shift @_;
  my $r = shift @_;
  
  return factorial($n) / (factorial($r) * factorial($n - $r));
} # selectionCombos()

for (my $num_n = 1; $num_n <= 100; $num_n++) {
  for (my $num_r = 1; $num_r <= $num_n; $num_r++) {
    my $result = selectionCombos($num_n, $num_r);
    if ($result > 1000000) {
      print "N: $num_n, R: $num_r, Result: $result\n";
      $answer++;
    }
  }
}


print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 4075