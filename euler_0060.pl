#!/opt/local/bin/perl

# Project Euler Problem #60
# The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating them in any
# order the result will always be prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The sum
# of these four primes, 792, represents the lowest sum for a set of four primes with this property.
# 
# Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.
# 
use strict;
use warnings;
use List::Util qw[min max reduce];
require "functions.pm";

sub checkPrimality($) {
  my @check = @{shift @_};

  for (my $x = 0; $x <= $#check; $x++) {
    for (my $y = 0; $y <= $#check; $y++) {
      if ($x != $y) {
        my $poss_prime = $check[$x] . $check[$y];
        my $is_it = isPrime($poss_prime) ? 1 : 0;
        if (!$is_it) {
          return 0;
        }
      }
    }
  }
  return 1;
} # checkPrimality()

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = 0;
my %comp_primes;
my $cnt  = 0;
my @primes = (loadedPrimes('array'))[0..1600];
my $done = 0;
while ($primes[$cnt++] < 10000) {
  
}
@primes = @primes[0..$cnt];

my @check;

for (my $i1 = 0; $i1 < scalar @primes - 5; $i1++) {
  push @check, $primes[$i1];
  for (my $i2 = $i1 + 1; $i2 < scalar @primes - 4; $i2++) {
    push @check, $primes[$i2];
    if (checkPrimality(\@check)) {
      tick(join(', ', @check) . '                                               ');
      for (my $i3 = $i2 + 1; $i3 < scalar @primes - 3; $i3++) {
        push @check, $primes[$i3];
        if (checkPrimality(\@check)) {
          tick(join(', ', @check) . '                                               ');
          for (my $i4 = $i3 + 1; $i4 < scalar @primes - 2; $i4++) {
            push @check, $primes[$i4];
            if (checkPrimality(\@check)) {
              tick(join(', ', @check) . '                                               ');
              for (my $i5 = $i4 + 1; $i5 < scalar @primes - 1; $i5++) {
                push @check, $primes[$i5];
                if (checkPrimality(\@check)) {
                  $done = 1;
                }
                if ($done) { last; }
                pop @check;
              }
            }
            if ($done) { last; }
            pop @check;
          }
        }
        if ($done) { last; }
        pop @check;
      }
    }
    if ($done) { last; }
    pop @check;
  }
  if ($done) { last; }
  pop @check;
}

$answer = join(' + ', @check) . " = " . (reduce {$a + $b} @check) . "\n";

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 