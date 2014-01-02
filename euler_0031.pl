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
#use warnings;
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

my %expansions = (
  200 => [100, 100],
  100 => [50, 50],
  50  => [20, 20, 10],
  20  => [10, 10],
  10  => [5, 5],
  5   => [2, 2, 1],
  2   => [1, 1]
);

my %coin_combos;

sub expands($) {
  return defined $expansions{shift @_};
} # expands()

sub genKey($) {
  my @c_arr = @{shift @_};
  my %count;
  map { $count{$_}++ } sort @c_arr;
  
  my $hash_key = join(' + ', map {"($printable{$_} x ${count{$_}})"} sort {$b <=> $a} keys(%count));
  
  return $hash_key;
}

sub nextExpansion($) {
  my @c_arr = @{shift @_};
  
  my $big = -1;
  my $big_idx = -1;
  
  for (my $i = 0; $i < scalar @c_arr; $i++) {
    if ($c_arr[$i] > $big && expands($c_arr[$i])) {
      $big = $c_arr[$i];
      $big_idx = $i;
    }
  }
  
  return $big_idx;
} # nextExpansion()

sub makeCombos($) {
  my @c_arr = @{shift @_};
  
  
  my $key = genKey(\@c_arr);
  if (!defined $coin_combos{$key}) {
    dbgMsg("$key\n");
    $coin_combos{$key} = 1;
  }
  
  my @new_arr;
  for (my $i = 0; $i <= $#c_arr; $i++) {
    if (expands($c_arr[$i])) {
      @new_arr = (@c_arr[0..$i-1], @{$expansions{$c_arr[$i]}}, @c_arr[$i+1..$#c_arr]);
      $key = genKey(\@new_arr);
      if (!defined $coin_combos{$key}) {
        dbgMsg("$key\n");
        $coin_combos{$key} = 1;
        makeCombos(\@new_arr);
      }
    }
  }
} # makeCombos()

my $target = 100;

my @tar = ($target);
my $scl = \@tar;

print "Finding all coin combinations for $printable{$target}...\n";

#debugOff();

makeCombos($scl);

print "\n\nAnswer: " . scalar(keys %coin_combos) . "\n\n";

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 