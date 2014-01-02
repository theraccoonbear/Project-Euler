#!/opt/local/bin/perl

# Project Euler Problem #65
# The square root of 2 can be written as an infinite continued fraction.
# Ã2 = 1 + 	
# 1
# 
#   	2 + 	
# 1
# 
#   	  	2 + 	
# 1
# 
#   	  	  	2 + 	
# 1
# 
#   	  	  	  	2 + ...
# 
# The infinite continued fraction can be written, Ã2 = [1;(2)], (2) indicates that 2 repeats ad infinitum. In a similar way, Ã23 = [4;(1,3,1,8)].
# 
# It turns out that the sequence of partial values of continued fractions for square roots provide the best rational approximations. Let us consider the convergents for Ã2.
# 1 + 	
# 1
# 
# 	= 3/2
#   	
# 2
# 	 
# 1 + 	
# 1
# 
# 	= 7/5
#   	2 + 	
# 1
# 
#   	  	
# 2
# 	 
# 1 + 	
# 1
# 
# 	= 17/12
#   	2 + 	
# 1
# 
# 	 
#   	  	2 + 	
# 1
# 
# 	 
#   	  	  	
# 2
# 	 
# 1 + 	
# 1
# 
# 	= 41/29
#   	2 + 	
# 1
# 
#   	  	2 + 	
# 1
# 
# 	 
#   	  	  	2 + 	
# 1
# 
# 	 
#   	  	  	  	
# 2
# 	 
# 
# Hence the sequence of the first ten convergents for Ã2 are:
# 1, 3/2, 7/5, 17/12, 41/29, 99/70, 239/169, 577/408, 1393/985, 3363/2378, ...
# 
# What is most surprising is that the important mathematical constant,
# e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].
# 
# The first ten terms in the sequence of convergents for e are:
# 2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...
# 
# The sum of digits in the numerator of the 10^(th) convergent is 1+4+5+7=17.
# 
# Find the sum of digits in the numerator of the 100^(th) convergent of the continued fraction for e.
# 
# use strict;
use warnings;
use bigint;
require "functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = 0;

my @e_contfrac = (2, 1);

for (my $i = 2; $i < 10000; $i += 2) {
  push @e_contfrac, ($i, 1, 1);
}


dbgMsg('[[' . $e_contfrac[0] . ';' . join(',', @e_contfrac[1..100]) . "]]\n\n");


my $num = 1;
my $den = 1;
my $cnt = 0;

for (my $start = 1; $start < 100; $start++) {

  $num = 1;
  $den = $e_contfrac[$start];;
  $cnt = 0;
  
  for (my $i = $start - 1; $i > 0; $i--) {
    $num = ($e_contfrac[$i] * $den) + $num;
    ($den, $num) = ($num, $den);
  }
  
  $num = ($e_contfrac[0] * $den) + $num;
  $answer = sumArray(split(//, $den));  
  dbgMsg("$start) $num / $den = ($answer)\n");
}

$answer = sumArray(split(//, $num));

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 272