#!/opt/local/bin/perl

# Project Euler Problem #0
# 
use strict;
use warnings;
require "functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = 0;

#
# Code goes here...
#


print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 