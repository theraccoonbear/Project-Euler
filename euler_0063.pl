#!/opt/local/bin/perl

# Project Euler Problem #63
# The 5-digit number, 16807=7^5, is also a fifth power. Similarly, the 9-digit number, 134217728=8^9, is a ninth power.
#
# How many n-digit positive integers exist which are also an nth power?
#
use strict;
use warnings;
require "functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';

for my $n ((1..100000)) {
  my $cnt = 0;
  for my $pow ((1..100)) {
    my $result = $n ** $pow;
    my $len = length($result);
    if ($result =~ m/(\d+)(\.\d+)?e[\+\-]?(\d+)/gi) {
      $len = length($1) + $3;
    }
    if ($len == $pow) {
      $answer++;
      dbgMsg("len: $len ::: $n ^ $pow = " . ($n ** $pow) . " ::: $answer\n");
      $cnt++;
    }
  }
  
  if ($cnt != 0) { dbgMsg("\n"); }
}


print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 49