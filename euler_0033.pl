#!/opt/local/bin/perl

# Project Euler Problem #33
#c
# The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe
# that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.
# 
# We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
# 
# There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.
# 
# If the product of these four fractions is given in its lowest common terms, find the value of the denominator.
#
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

print "Timing started....\n\n";
startTiming();



my $rn;
my $rd;
my $dnum;
my $ddenom;
my $cancelled;
my $output;
my $total = 1;

for (my $denom = 10; $denom < 99; $denom++) {
  for (my $num = 10; $num < $denom; $num++) {
    $output = 0;
    if (substr($num, 0, 1) eq substr($denom, 1, 1) && substr($denom, 0, 1) ne '0') {
      if ($num / $denom == substr($num, 1, 1) / substr($denom, 0, 1)) {
        $rn = substr($num, 1, 1);
        $rd = substr($denom, 0, 1);
        $dnum = sprintf('%3s', $num);
        $ddenom = sprintf('%3s', $denom);
        $cancelled = substr($num, 0, 1);
        $output = 1;
      }
    } elsif (substr($num, 1, 1) eq substr($denom, 0, 1) && substr($denom, 1, 1) ne '0') {
      if ($num / $denom == substr($num, 0, 1) / substr($denom, 1, 1)) {
        $rn = substr($num, 0, 1);
        $rd = substr($denom, 1, 1);
        $dnum = sprintf('%3s', $num);
        $ddenom = sprintf('%3s', $denom);
        $cancelled = substr($num, 1, 1);
        $output = 1;
        #print "$num / $denom == " . substr($num, 0, 1) . ' / ' . substr($denom, 1, 1) . " -- Cancelled: " . substr($num, 1, 1) . "\n";
      }
    }
    
    if ($output) {
      $total *= ($num/$denom);
      
      print <<__FO;
        $dnum      $rn
        ---- == ---
        $ddenom      $rd    Cancelled: $cancelled
~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=~=
__FO
    }
  }
}

$total = ($total =~ m/\.(\d+)$/ ? $total * ('1' . ('0' x (length($1) * 2))) : 'NaN');

print "\n\nAnswer: $total\n\n";

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";

# Answer: 100