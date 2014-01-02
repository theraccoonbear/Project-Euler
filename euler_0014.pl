#!/opt/local/bin/perl

# Project Euler Problem #14
#
# The following iterative sequence is defined for the set of positive integers:
# 
# n -> n/2 (n is even)
# n -> 3n + 1 (n is odd)
# 
# Using the rule above and starting with 13, we generate the following sequence:
# 13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1
# 
# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.
# 
# Which starting number, under one million, produces the longest chain?
# 
# NOTE: Once the chain starts the terms are allowed to go above one million.


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

sub nextVal($);
sub chainLength($);

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

my @memo = ();

sub nextVal($) {
  my $val = shift @_;
  
  if ($val % 2 == 0) {
    return $val / 2;
  } else {
    return $val * 3 + 1;
  }
} # next()

sub chainLength($) {
  my $val = shift(@_);
  my $orig = $val;
  my $chain = 1;
  
  dbgMsg("------ASSESSING: $val\n");
  
  while ($val != 1) {
    if (defined $memo[$val]) {
      dbgMsg("Cache hit for $val is chain length of $memo[$val] yielding " . ($memo[$val] + $chain) ." for $orig\n");
      $memo[$orig] = $memo[$val] + $chain;
      return $memo[$orig];
    } else {
      $val = nextVal($val);
      $chain++;
    }
  }
  
  dbgMsg("Caching chain length of $chain for value of $orig\n");
  $memo[$orig] = $chain;
  
  return $memo[$orig];
} # chainLength()

my $longest_chain = 0;
my $longest_chain_init = 0;
my $x = 0;
my $chain = 0;

startTiming();

debugOn();

for ($x = 1; $x <= 1000000; $x++) {
  $chain = chainLength($x);
  
  if ($chain > $longest_chain) {
     dbgMsg("\n\n        New longest chain for value $x found to be $chain\n\n");
     #sleep 1;
     $longest_chain = $chain;
     $longest_chain_init = $x;
  }
  
}

print "\n\n" . endTiming() . " seconds elapsed\n\n";

print "\nLongest chain of $longest_chain starting from $longest_chain_init.\n\n";

# Answer: 837799