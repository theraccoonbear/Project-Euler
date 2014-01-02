#!/opt/local/bin/perl

# Project Euler Problem #0
#
# The decimal number, 585 = 1001001001 (binary), is palindromic in both bases.
# 
# Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.
# 
# (Please note that the palindromic number, in either base, may not include leading zeros.)
# 


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

print "Timing started....\n\n";
startTiming();


sub dec2bin {
  my $str = unpack("B32", pack("N", shift));
  $str =~ s/^0+(?=\d)//;   # otherwise you'll get leading zeros
  return $str;
} # dec2bin()

my $dbg = '';

sub isPalindromic($) {
  my $val = shift @_;
  my $len = length($val);
  
  if ($len == 1) { return 1; }
  
  my $cut = int($len / 2);
  
  $dbg .= "\n$val\n"; 
  
  for (my $i = 0; $i < $cut; $i++) {
    
    $dbg .= "  [$i] " . substr($val, $i, 1) . ' == ' . substr($val, -($i + 1), 1) ."\n";
    
    if (substr($val, $i, 1) ne substr($val, -($i + 1), 1)) {
      return 0;
    }
  }
  
  $dbg .= "\n";
  
  return 1;
} # isPalindromic()

my $answer = 0;

foreach my $x (1..1000000) {
  $dbg = '';
  if (isPalindromic($x)) {
    my $br = dec2bin($x);
    if (isPalindromic($br)) {
      print "$x ::: $br\n";
      print $dbg;
      print "~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=\n";
      $answer += $x;
    }
  }
}

print "\n\nAnswer: $answer\n\n";

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 872187