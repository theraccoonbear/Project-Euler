#!/opt/local/bin/perl

# Project Euler Problem #17
#
# If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
#
# If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
# 
# NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.

use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);


my %ones_teens_map = (
  '0'   => '',
  '1'   => 'one',
  '2'   => 'two',
  '3'   => 'three',
  '4'   => 'four',
  '5'   => 'five',
  '6'   => 'six',
  '7'   => 'seven',
  '8'   => 'eight',
  '9'   => 'nine',
  '10'  => 'ten',
  '11'  => 'eleven',
  '12'  => 'twelve',
  '13'  => 'thirteen',
  '14'  => 'fourteen',
  '15'  => 'fifteen',
  '16'  =>  'sixteen',
  '17'  => 'seventeen',
  '18'  => 'eighteen',
  '19'  => 'nineteen'
);

my %tens_map = (
  '2' => 'twenty',
  '3' => 'thirty',
  '4' => 'forty',
  '5' => 'fifty',
  '6' => 'sixty',
  '7' => 'seventy',
  '8' => 'eighty',
  '9' => 'ninety',
);

sub numberToWord($) {
  my $val = shift @_;
  my $result = '';
  my ($ones, $tens, $hundreds, $thousands) = (0,0,0,0);
  
  if ($val < 20) {
    $result = $ones_teens_map{$val};
  } else {
    if ($val =~ m/^\d{2,4}$/) {
      my @digits = split(//, $val);
      $ones = $digits[-1];
      $tens = $digits[-2];
      $hundreds = $digits[-3];
      $thousands = $digits[-4];
      
      $result .= (defined $thousands && $thousands != 0? $ones_teens_map{$thousands} . ' thousand' : '');
      $result .= (defined $hundreds && $hundreds != 0 ? $ones_teens_map{$hundreds} . ' hundred ' . ($tens != 0 || $ones != 0 ? 'and ' : ''): '');
      $result .= (defined $ones_teens_map{$tens . $ones} ? $ones_teens_map{$tens . $ones} : (defined $tens && $tens  != 0 ? $tens_map{$tens}  . ($ones != 0 ? '-' : '') : ''));
      $result .= (defined $ones && $ones != 0 && !defined $ones_teens_map{$tens .  $ones} ? $ones_teens_map{$ones} : '');
    } else {
      dbgMsg("WTF? $val\n");
    }
  }
  
  return $result;
  
}

my $letter_cnt= 0;

#debugOff();

for (my $x = 1; $x <= 1000; $x++) {
  my $word = numberToWord($x);
  dbgMsg("$x = $word = ");
  $word =~ s/[^A-Za-z]+//g;
  $letter_cnt += length($word);
  dbgMsg(length($word) . " = " . $letter_cnt . "\n");
}

print "\n\nAnswer: $letter_cnt\n\n";


# Answer: 21124