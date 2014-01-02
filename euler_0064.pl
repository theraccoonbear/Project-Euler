#!/opt/local/bin/perl

# Project Euler Problem #64
# All square roots are periodic when written as continued fractions and can be written in the form:
# �N = a_(0) + 	
# 1
#   	a_(1) + 	
# 1
#   	  	a_(2) + 	
# 1
#   	  	  	a_(3) + ...
# 
# For example, let us consider �23:
# �23 = 4 + �23 � 4 = 4 +  	
# 1
# 	 = 4 +  	
# 1
#   	
# 1
# �23�4
# 	  	1 +  	
# �23 � 3
# 7
# 
# If we continue we would get the following expansion:
# �23 = 4 + 	
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
# �23�4
# 	 =  	
# �23+4
# 7
# 	 = 1 +  	
# �23�3
# 7
# a_(1) = 1, 	  	
# 7
# �23�3
# 	 =  	
# 7(�23+3)
# 14
# 	 = 3 +  	
# �23�3
# 2
# a_(2) = 3, 	  	
# 2
# �23�3
# 	 =  	
# 2(�23+3)
# 14
# 	 = 1 +  	
# �23�4
# 7
# a_(3) = 1, 	  	
# 7
# �23�4
# 	 =  	
# 7(�23+4)
# 7
# 	 = 8 +  	�23�4
# a_(4) = 8, 	  	
# 1
# �23�4
# 	 =  	
# �23+4
# 7
# 	 = 1 +  	
# �23�3
# 7
# a_(5) = 1, 	  	
# 7
# �23�3
# 	 =  	
# 7(�23+3)
# 14
# 	 = 3 +  	
# �23�3
# 2
# a_(6) = 3, 	  	
# 2
# �23�3
# 	 =  	
# 2(�23+3)
# 14
# 	 = 1 +  	
# �23�4
# 7
# a_(7) = 1, 	  	
# 7
# �23�4
# 	 =  	
# 7(�23+4)
# 7
# 	 = 8 +  	�23�4
# 
# It can be seen that the sequence is repeating. For conciseness, we use the notation �23 = [4;(1,3,1,8)], to indicate that the block (1,3,1,8) repeats indefinitely.
# 
# The first ten continued fraction representations of (irrational) square roots are:
# 
# �2=[1;(2)], period=1
# �3=[1;(1,2)], period=2
# �5=[2;(4)], period=1
# �6=[2;(2,4)], period=2
# �7=[2;(1,1,1,4)], period=4
# �8=[2;(1,4)], period=2
# �10=[3;(6)], period=1
# �11=[3;(3,6)], period=2
# �12= [3;(2,6)], period=2
# �13=[3;(1,1,1,1,6)], period=5
# 
# Exactly four continued fractions, for N � 13, have an odd period.
# 
# How many continued fractions for N � 10000 have an odd period?
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