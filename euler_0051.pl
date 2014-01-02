#!/opt/local/bin/perl

# Project Euler Problem #51
#
# By replacing the 1^(st) digit of *3, it turns out that six of the nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.
# 
# By replacing the 3^(rd) and 4^(th) digits of 56**3 with the same digit, this 5-digit number is the first example having seven primes among the ten
# generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993. Consequently 56003, being the first member of this
# family, is the smallest prime with this property.
# 
# Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.
#
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';

my @primes = loadedPrimes('array');
my @np = ();

dbgMsg("\n\nSearching for prime families...\n\n");


for (my $i = 0; $i < scalar @primes; $i++) {
  my $prime = $primes[$i];
  if ($prime =~ m/(\d).*?\1/gi) {
    my $md = $1;
    @np = ();
    for my $nd ((0..9)) {
      my $tprime = $prime;
      $tprime =~ s/$md/$nd/gi;
      if (isPrime($tprime)) {
        push @np, $tprime;
      }
    }
    if (scalar @np > 7) {
      $answer = join(', ', sort @np);
      last;
    }
  }
  if ($i % 1000 == 0) { tick(join(', ', sort @np)); }
  
}

print "\n\nAnswer: $answer\n\n";

endTiming();

# Answer: 121313