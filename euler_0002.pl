#!/opt/local/bin/perl

# Project Euler Problem #2
#
# Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:
#
# 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, .. 
#
# Find the sum of all the even-valued terms in the sequence which do not exceed four million.

my $first = 1;
my $second = 2;
my $total = 2;
my $quit = 0;
$fib = 0;

while ($fib < 4000000 && (!$quit)) {
  $fib = $first + $second;
  
  if ($fib % 2 == 0) {
    if ($fib < 4000000) {
      $total += $fib;
    } else {
      $quit = 1;
    }
  }
  
  print "$fib [$total], ";
  
  $first = $second;
  $second = $fib;
}

print "\n\nTOTAL: $total\n\n";

# Answer: 1089154