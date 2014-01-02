#!/opt/local/bin/perl

# Project Euler Problem #62
# The cube, 41063625 (345^(3)), can be permuted to produce two other cubes: 56623104 (384^(3)) and 66430125 (405^(3)). In fact,
# 41063625 is the smallest cube which has exactly three permutations of its digits which are also cube.
# 
# Find the smallest cube for which exactly five permutations of its digits are cube.
# 
use strict;
use warnings;
require "functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';
my $num = 1;
my $big_cnt = 0;
my $big_cube;
my %rootie;
my $cube;
my $norm;
my @watch;

while ($num < 10000 && $big_cnt < 5) {
  $cube  = $num ** 3;
  $norm = normalizedPermutation($cube);
  $rootie{$norm}++;
  if ($norm eq '012334556789') {
    push @watch, $num;
  }
  if ($rootie{$norm} > $big_cnt) {
    $big_cnt = $rootie{$norm};
    $big_cube = $cube;
  }
  $num++;
}

#print "$norm = $big_cube = $rootie{$norm} = $num\n\n";

print join(', ', sort @watch) . "\n";
print join(', ', map $_**3, sort @watch) . "\n";

$answer = $big_cube;

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 127035954683