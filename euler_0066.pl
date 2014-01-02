#!/opt/local/bin/perl

# Project Euler Problem #66
# Consider quadratic Diophantine equations of the form:
# 
# x^(2) Ð Dy^(2) = 1
# 
# For example, when D=13, the minimal solution in x is 649^(2) Ð 13*180^(2) = 1.
# 
# It can be assumed that there are no solutions in positive integers when D is square.
# 
# By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the following:
# 
# 3^(2) Ð 2*2^(2) = 1
# 2^(2) Ð 3*1^(2) = 1
# 9^(2) Ð 5*4^(2) = 1
# 5^(2) Ð 6*2^(2) = 1
# 8^(2) Ð 7*3^(2) = 1
# 
# Hence, by considering minimal solutions in x for D ² 7, the largest x is obtained when D=5.
# 
# Find the value of D ² 1000 in minimal solutions of x for which the largest value of x is obtained.
# 
use strict;
use warnings;
#use bignum(p => -100);
require "functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = 0;

my $big_x = 0;
my $big_d = 0;
my ($x, $y, $break_out);
my $nsg = 2;
my $ns = 4;

print "Initial D: ";
my $sdv = <STDIN>;
chomp($sdv);


#for (my $d = $sdv; $d <= 1000; $d++) {
for (my $d = $sdv; $d > 2; $d--) {
  #if (sqrt($d) == int(sqrt($d))) {
  if ($d == $ns) {
    dbgMsg("\n$d is square\n\n");
    $nsg++;
    $ns = $nsg**2;
    next;
  }
  $x = 0;
  $break_out = 0;
  while (!$break_out) { # && $x < 1000000) {
    $x++;
    if ($x % 100000 == 0) { tick("X: $x --- D: $d "); } 
    my $iv = (1 - $x**2) / -$d;
    if ($iv > 0) {
      $y = sqrt($iv);
      if ($y == int($y)) {
        if ($x > $big_x) {
          $big_x = $x;
          $big_d = $d;
        }
        $break_out = 1;
      }
    }
  }
  
  dbgMsg("D: $d --- X: $x --- Y: $y\n");
  dbgMsg("BIG D: $big_d, BIG X: $big_x\n\n");
}

$answer = "D: $big_d, X: $big_x";


print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 