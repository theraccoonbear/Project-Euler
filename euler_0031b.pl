#!/opt/local/bin/perl

# Project Euler Problem #31
#
# In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:
# 
#     1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
# 
# It is possible to make £2 in the following way:
# 
#     1 * £1 + 1 * 50p + 2 * 20p + 1 * 5p + 1 * 2p + 3 * 1p
# 
# How many different ways can £2 be made using any number of coins?
#
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

sub expands($);
sub genKey($);
sub makeCombos($);

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

print "Timing started....\n\n";
startTiming();

my @coins = (1, 2, 5, 10, 20, 50, 100, 200);


my %printable = (
  1 => '1p',
  2 => '2p',
  5 => '5p',
  10 => '10p',
  20 => '20p',
  50 => '50p',
  100 => '£1',
  200 => '£2'
);

my %counts = (
  1   => 0,
  2   => 0,
  5   => 0,
  10  => 0,
  20  => 0,
  50  => 0,
  100 => 0,
  200 => 0
);

my $target = 100;
my $answer;
my $total;

sub sum() {
  my $s = 0;
  map {$s += $counts{$_} * $_} (2, 5, 10, 20, 50, 100, 200);
  return $s;
}

while (1) {
  my $sum = sum();
  $counts{1} = $target - $sum;
  if ($counts{1} < 0) { $counts{1} = 0; }
  if ($counts{1} > $target) { $counts{1} = $target; }
  $sum += $counts{1};
  
  if ($sum == $target) {
    $answer++;
    print "Combo #$answer = " . join(' + ', map {$counts{$_} . 'x' . $printable{$_}} sort {$a <=> $b} keys %counts) . "\n";
    my $cc = 0;
    map { $cc += $counts{$_} } keys %counts;
    if ($cc == 1) { last; }
  }
  
  $counts{2}++;
  for (my $i = 0; $i <= 6; $i++) {
    if ($counts{$coins[$i]} * $coins[$i] > $target) {
      $counts{$coins[$i+1]}++;
      $counts{$coins[$i]} = 0;
    }
    if ($counts{200} > 0) {
      last;
    }
  }
  
  
}

print "\n\nAnswer: $answer\n\n";

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 73682