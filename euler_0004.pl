#!/opt/local/bin/perl

# Project Euler Problem #4
#
# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 ? 99.
# 
# Find the largest palindrome made from the product of two 3-digit numbers.

use strict;
use warnings;

my @CHECKED = ();
my $largest = 0;

sub isPalindrome($) {
  my $val = shift @_;
  my $len = length $val;
  
  for (my $i = 0; $i < $len / 2; $i++) {
    if (substr($val, $i, 1) ne substr($val, $len - $i - 1, 1)) {
      return 0;
    }
  }
  
  return 1;
}

for (my $x = 100; $x < 1000; $x++) {
  for (my $y = 100; $y < 1000; $y++) {
    my $check = $x * $y;
    
    if (!defined $CHECKED[$check] && !defined $CHECKED[$check]) {
      
      $CHECKED[$check] = isPalindrome($check);
      
      if ($CHECKED[$check]) {
        if ($check > $largest) {
          $largest = $check;
        }
      }
      
    }
  }
}

print "\n\nLargest: $largest\n\n";


# Answer: 906609