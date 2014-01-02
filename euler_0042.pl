#!/opt/local/bin/perl

# Project Euler Problem #42
#
# The n^(th) term of the sequence of triangle numbers is given by, t(n) = 1/2n(n+1); so the first ten triangle numbers are:
# 
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
# 
# By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value.
# For example, the word value for SKY is 19 + 11 + 25 = 55 = t(10). If the word value is a triangle number then we shall call the word a triangle word.
# 
# Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how
# many are triangle words?
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = 0;

dbgMsg("loading words...\n");
open MFH, "<words.txt";
my $lod = <MFH>;
close MFH;
chomp($lod);
$lod =~ s/"//gi;
my @words = split(/,/, $lod);
dbgMsg("...done\n");


dbgMsg("Finding triangle numbers...\n");
my %triangles;
for (my $i = 1; $i < 10000; $i++) {
  $triangles{(.5 * $i * ($i+1))} = $i;
}
dbgMsg("...done\n");

foreach my $word (@words) {
  my $word_num = 0;
  foreach my $letter (split(//, $word)) {
    $word_num += ord($letter) - 64;
  }
  if (defined $triangles{$word_num}) {
    print "$word is a triangle word of value $word_num\n";
    $answer++;
  }
}


print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 