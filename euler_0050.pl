#!/opt/local/bin/perl

# Project Euler Problem #50
#
# The prime 41, can be written as the sum of six consecutive primes:
# 41 = 2 + 3 + 5 + 7 + 11 + 13
# 
# This is the longest sum of consecutive primes that adds to a prime below one-hundred.
# 
# The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.
# 
# Which prime, below one-million, can be written as the sum of the most consecutive primes?
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';

my @primes = loadedPrimes('array');

my $rt = 0;
my $cnt = 0;
my $biggest = 0;
my $start = 0;
my @used;
my @big_used;

for (my $start = 0; $start < scalar @primes; $start++) {
  if ($primes[$start] >= 1000000) { last; }
  $rt = 0;
  @used = ();
  for (my $i = $start; $i < scalar @primes; $i++) {
    $rt += $primes[$i];
    
    if ($rt >= 1000000) {
      last;
    }
    
    push @used, $primes[$i];
    
    if (isPrime($rt) && $rt > $biggest && scalar(@used) > scalar(@big_used)) {
      @big_used = @used;
      $biggest = $rt;
      tick("$biggest");
    }
    
    if ($i % 1000 == 0) { tick("$biggest"); }
  }
}

$answer = $biggest;

print "\n\nPrimes Used (" . scalar(@big_used) . ") : " . join(' + ', @big_used) . "\n\n";

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 997651