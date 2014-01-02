#!/opt/local/bin/perl

# Project Euler Problem #22
#
# Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names,
# begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value
# by its alphabetical position in the list to obtain a name score.
#
# For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the
# 938th name in the list. So, COLIN would obtain a score of 938 * 53 = 49714.
#
# What is the total of all the name scores in the file?
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

my $data = '';

startTiming();

open MFH, "/Users/don/bin/scripts/euler/names.txt" or die $!;
while (my $lod = <MFH>) {
  $data .= $lod;
}
close MFH;

$data =~ s/","/,/g;

$data =~ s/"//g;

my @NAMES = sort {$a cmp $b} split(/,/, $data);

my $total = 0;

for (my $i = 0; $i <= $#NAMES; $i++) {
  my $name = $NAMES[$i];
  my $name_sum = 0;
  foreach my $c (split(//, $name)) {
    my $byte = (int(ord $c)) - 64;
    $name_sum += $byte;
  }
  my $name_score = $name_sum * ($i + 1);
  $total += $name_score;
  
  dbgMsg("$i)  $name :: $name_score ($total)\n");
}

print "\n\nAnswer: $total\n";

print "\n\n" . endTiming() . " second(s) elapsed.\n\n";


# Answer: 871198282