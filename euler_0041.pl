#!/opt/local/bin/perl

# Project Euler Problem #41
#
# We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.
# 
# What is the largest n-digit pandigital prime that exists?
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';
my $big_pandigital_prime = 0;
my $cnt = 0;
#my @prime_list = @{primes(100000)};

my %primes;
my $idx;

my %prime_memo;


for (my $n = 2; $n < 8000000; $n++) {
  if (isPandigital($n)) {
    undef $prime_memo{$n-1};
    delete $prime_memo{$n-1};
    if (! defined $prime_memo{$n}) {
      $prime_memo{$n} = 1;
      for (my $d = 2; $d < sqrt($n) + 1; $d++) {
        if ($n % $d == 0) {
          $prime_memo{$n} = 0;
          last;
        }
      }
      for (my $d = 2; $d < 10; $d++) {
        $prime_memo{$n * $d} = 0;
      }
    }
    if ($prime_memo{$n}) {
      if ($big_pandigital_prime < $n) {
        $big_pandigital_prime = $n;
      }
      #print "\n$n\n";
    }
  }
  if ($n % 20000 == 0) { tick($big_pandigital_prime);  }
}

$answer = $big_pandigital_prime;

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 7652413



