#!/opt/local/bin/perl

# Project Euler Problem #43
#
# The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.
# 
# Let d(1) be the 1st digit, d(2) be the 2nd digit, and so on. In this way, we note the following:
# 
#     * d(2)d(3)d(4)=406 is divisible by 2
#     * d(3)d(4)d(5)=063 is divisible by 3
#     * d(4)d(5)d(6)=635 is divisible by 5
#     * d(5)d(6)d(7)=357 is divisible by 7
#     * d(6)d(7)d(8)=572 is divisible by 11
#     * d(7)d(8)d(9)=728 is divisible by 13
#     * d(8)d(9)d(10)=289 is divisible by 17
# 
# Find the sum of all 0 to 9 pandigital numbers with this property.
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

sub permuteWithCheck($$);

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = 0;
my $last_divisible = '';
  my %divisors = (
    2 => 2,
    3 => 3,
    4 => 5,
    5 => 7,
    6 => 11,
    7 => 13,
    8 => 17
  );

my @list = (1,2,3,4,5,6,7,8,9,0);
my @c = ();
my $cnt = 0;
my $pcd = 0;
my $last_num = '';

sub checkNum($) {
  my $num = join('', @{shift @_});
  if (length($num) == 10 && isPandigital($num)) {
    my $is_divisible = 1;
    foreach my $key (sort keys %divisors) {
      if ($key < length($num)) {
        if (substr($num, $key - 1, 3) % $divisors{$key} != 0) {
          $is_divisible = 0;
        }
      }
    }
    if ($is_divisible) {
      $answer += $num;
      $last_num = $num;
      print "\n\nNew Number $num\n\n";
    }
    
    $pcd++;
    if ($pcd  % 10000 == 0) { tick("Searching.... total: $answer, last: $last_num, testing: $num"); }
  }
} # checkNum

sub permuteWithCheck($$) {
  my @v = @{shift @_};
  my @c = @{shift @_};
  my @intc = ();

  for (my $i = 0; $i < scalar @v; $i++) {
    my $sv = $v[$i];
    push @c, $sv;
    
    
    
    if ($#v > 0) {
      my @ta  = @v;
      splice(@ta, $i, 1);
      checkNum(\@c);
      #push @intc, permuteWithCheck(\@ta, \@c);
      permuteWithCheck(\@ta, \@c);
      pop @c;
    } else {
      checkNum(\@c);
      #push @intc, \@c;
    }
  }
  
  #print join('.', @intc) . "\n";
  
  if (length(join('', @intc)) == 10) {
    checkNum(\@intc);
  }
  #return @intc;
} # permuteWithCheck()


dbgMsg("Searching for pandigitals...\n\n");

permuteWithCheck(\@list, \@c);

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 16695334890