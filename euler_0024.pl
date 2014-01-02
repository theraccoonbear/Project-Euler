#!/opt/local/bin/perl

# Project Euler Problem #24
#
# A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4.
# If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic
# permutations of 0, 1 and 2 are:
#
# 012   021   102   120   201   210
#
# What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

print "Timing started....\n\n";
startTiming();

my @to_count = (0,1,2,3,4,5,6,7,8,9);
my $element_level = -1;
my @permutationValue = ();
my $permutationCount = 0;
my @perms = ();
my $answer = '';

sub calcPermutation($);

sub calcPermutation($) {
  my $k = shift @_;
  
  $element_level++;
  $permutationValue[$k] = $element_level;
  
  if ($element_level == $#to_count) {
    $permutationCount++;
    
    push @perms, join('', @permutationValue);
    
    if ($permutationCount % 1000 == 0) {
      dbgMsg('.');
    }    
  } else {
    for (my $i = $#to_count; $i >= 0; $i--) {
      if (!defined $permutationValue[$i] || $permutationValue[$i] == '0') {
        calcPermutation($i);
      }
    }
  }
  $element_level--;
  $permutationValue[$k] = 0;
} # calcPermutation()

print "Trying permutations... ";

calcPermutation(0);

@perms = sort {$a cmp $b} @perms;
$answer = $perms[999999];

print "\n\nPermutations: $permutationCount\n\n";

print "\n\nAnswer: $answer\n\n";

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 