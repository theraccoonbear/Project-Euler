#!/opt/local/bin/perl

# Project Euler Problem #19
#
# You are given the following information, but you may prefer to do some research for yourself.
# 
#     * 1 Jan 1900 was a Monday.
#     * Thirty days has September,
#       April, June and November.
#       All the rest have thirty-one,
#       Saving February alone,
#       Which has twenty-eight, rain or shine.
#       And on leap years, twenty-nine.
#     * A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
# 
# How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?
# 


use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

my $day_offset = 0;
my $month = 1;
my $year = 1901;
my $dom = 1;
my $dow = 1;
my $sunday_the_first_cnt = 0;
my $days_this_month = daysInMonth($month, $year);

while ($year != 2000 || $month != 12 || $dom != 31) {
  if ($dow == 7 && $dom == 1) {
    $sunday_the_first_cnt++;
    print "$sunday_the_first_cnt :: Sunday $month/$dom/$year\n";
  }
  
  
  $day_offset++;
  $dow++;
  $dom++;
  if ($dow > 7) { $dow = 1; }
  if ($dom > $days_this_month) {
    $dom = 1;
    $month++;
    if ($month > 12) {
      $month = 1;
      $year++;
    }
    $days_this_month = daysInMonth($month, $year);
  }
}

print "\n\HALTED AT: $month/$dom/$year\n";

print "\n\nAnswer: $sunday_the_first_cnt\n\n";

# Answer: 171