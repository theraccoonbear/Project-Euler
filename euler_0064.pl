#!/opt/local/bin/perl

# Project Euler Problem #64
# All square roots are periodic when written as continued fractions and can be written in the form:
# ÃN = a_(0) + 	
# 1
#   	a_(1) + 	
# 1
#   	  	a_(2) + 	
# 1
#   	  	  	a_(3) + ...
# 
# For example, let us consider Ã23:
# Ã23 = 4 + Ã23 Ñ 4 = 4 +  	
# 1
# 	 = 4 +  	
# 1
#   	
# 1
# Ã23Ñ4
# 	  	1 +  	
# Ã23 Ð 3
# 7
# 
# If we continue we would get the following expansion:
# Ã23 = 4 + 	
# 1
#   	1 + 	
# 1
#   	  	3 + 	
# 1
#   	  	  	1 + 	
# 1
#   	  	  	  	8 + ...
# 
# The process can be summarised as follows:
# a_(0) = 4, 	  	
# 1
# Ã23Ñ4
# 	 =  	
# Ã23+4
# 7
# 	 = 1 +  	
# Ã23Ñ3
# 7
# a_(1) = 1, 	  	
# 7
# Ã23Ñ3
# 	 =  	
# 7(Ã23+3)
# 14
# 	 = 3 +  	
# Ã23Ñ3
# 2
# a_(2) = 3, 	  	
# 2
# Ã23Ñ3
# 	 =  	
# 2(Ã23+3)
# 14
# 	 = 1 +  	
# Ã23Ñ4
# 7
# a_(3) = 1, 	  	
# 7
# Ã23Ñ4
# 	 =  	
# 7(Ã23+4)
# 7
# 	 = 8 +  	Ã23Ñ4
# a_(4) = 8, 	  	
# 1
# Ã23Ñ4
# 	 =  	
# Ã23+4
# 7
# 	 = 1 +  	
# Ã23Ñ3
# 7
# a_(5) = 1, 	  	
# 7
# Ã23Ñ3
# 	 =  	
# 7(Ã23+3)
# 14
# 	 = 3 +  	
# Ã23Ñ3
# 2
# a_(6) = 3, 	  	
# 2
# Ã23Ñ3
# 	 =  	
# 2(Ã23+3)
# 14
# 	 = 1 +  	
# Ã23Ñ4
# 7
# a_(7) = 1, 	  	
# 7
# Ã23Ñ4
# 	 =  	
# 7(Ã23+4)
# 7
# 	 = 8 +  	Ã23Ñ4
# 
# It can be seen that the sequence is repeating. For conciseness, we use the notation Ã23 = [4;(1,3,1,8)], to indicate that the block (1,3,1,8) repeats indefinitely.
# 
# The first ten continued fraction representations of (irrational) square roots are:
# 
# Ã2=[1;(2)], period=1
# Ã3=[1;(1,2)], period=2
# Ã5=[2;(4)], period=1
# Ã6=[2;(2,4)], period=2
# Ã7=[2;(1,1,1,4)], period=4
# Ã8=[2;(1,4)], period=2
# Ã10=[3;(6)], period=1
# Ã11=[3;(3,6)], period=2
# Ã12= [3;(2,6)], period=2
# Ã13=[3;(1,1,1,1,6)], period=5
# 
# Exactly four continued fractions, for N ² 13, have an odd period.
# 
# How many continued fractions for N ² 10000 have an odd period?
# 
use strict;
use warnings;
use List::Util qw[min max];
use POSIX qw[ceil floor];
require "functions.pm";

sub findContFrac($);

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = 0;
my $cd = 0;
my $on = 23;
my $tn = $on;
my @cf;
my $approx;

$answer = 0;
for my $n ((2..10000)) {
  if (sqrt($n) != floor(sqrt($n))) {
    my @contfrac = getContFracSeq($n);
    print "$n : [" . $contfrac[0] . ';(' . join(',', @contfrac[1..$#contfrac]) . ")] $#contfrac\n";
    $answer += ($#contfrac % 2 != 0 ? 1 : 0);
  }
}
print "\n\nAnswer: $answer";

endTiming();


# this took a tremendous amount of time
# Answer: 1322