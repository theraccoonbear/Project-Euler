#!/opt/local/bin/perl

# Project Euler Problem #54
# In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:
# 
#     * High Card: Highest value card.
#     * One Pair: Two cards of the same value.
#     * Two Pairs: Two different pairs.
#     * Three of a Kind: Three cards of the same value.
#     * Straight: All cards are consecutive values.
#     * Flush: All cards of the same suit.
#     * Full House: Three of a kind and a pair.
#     * Four of a Kind: Four cards of the same value.
#     * Straight Flush: All cards are consecutive values of same suit.
#     * Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
# 
# The cards are valued in the order:
# 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
# 
# If two players have the same ranked hands then the rank made up of the highest value wins; for example, a pair of eights beats a pair of
# fives (see example 1 below). But if two ranks tie, for example, both players have a pair of queens, then highest cards in each hand are
# compared (see example 4 below); if the highest cards tie then the next highest cards are compared, and so on.
# 
# Consider the following five hands dealt to two players:
# Hand	 	Player 1	 	Player 2	 	Winner
# 1	 	5H 5C 6S 7S KD
# Pair of Fives
# 	 	2C 3S 8S 8D TD
# Pair of Eights
# 	 	Player 2
# 2	 	5D 8C 9S JS AC
# Highest card Ace
# 	 	2C 5C 7D 8S QH
# Highest card Queen
# 	 	Player 1
# 3	 	2D 9C AS AH AC
# Three Aces
# 	 	3D 6D 7D TD QD
# Flush with Diamonds
# 	 	Player 2
# 4	 	4D 6S 9H QH QC
# Pair of Queens
# Highest card Nine
# 	 	3D 6D 7H QD QS
# Pair of Queens
# Highest card Seven
# 	 	Player 1
# 5	 	2H 2D 4C 4D 4S
# Full House
# With Three Fours
# 	 	3C 3D 3S 9S 9D
# Full House
# with Three Threes
# 	 	Player 1
# 
# The file, poker.txt, contains one-thousand random hands dealt to two players. Each line of the file contains ten cards (separated by a
# single space): the first five are Player 1's cards and the last five are Player 2's cards. You can assume that all hands are valid (no
# invalid characters or repeated cards), each player's hand is in no specific order, and in each hand there is a clear winner.
# 
# How many hands does Player 1 win?
# 
use strict;
use warnings;
require "/Users/don/bin/scripts/euler/functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';
my @cards;
my @p1;
my @p2;

my %suit_map = (
  'H' => 'Hearts',
  'D' => 'Diamonds',
  'C' => 'Clubs',
  'S' => 'Spades'
);

my %face_map = (
  '1' => '1',
  '2' => '2',
  '3' => '3',
  '4' => '4',
  '5' => '5',
  '6' => '6',
  '7' => '7',
  '8' => '8',
  '9' => '9',
  'T' => '10',
  'J' => 'Jack',
  'Q' => 'Queen',
  'K' => 'King',
  'A' => 'Ace',
);

my %face_val= (
  '1' => 1,
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9,
  'T' => 10,
  'J' => 11,
  'Q' => 12,
  'K' => 13,
  'A' => 14,
);

my %hands = (
   10 => 'High Card',
   20 => 'Pair',
   30 => 'Two Pair',
   40 => 'Three of a Kind',
   50 => 'Straight',
   60 => 'Flush',
   70 => 'Full House',
   80 => 'Four of a Kind',
   90 => 'Straight Flush',
  100 => 'Royal Flush'
);

  #  10    * High Card: Highest value card.
  #  20    * One Pair: Two cards of the same value.
  #  30    * Two Pairs: Two different pairs.
  #  40    * Three of a Kind: Three cards of the same value.
  #  50    * Straight: All cards are consecutive values.
  #  60    * Flush: All cards of the same suit.
  #  70    * Full House: Three of a kind and a pair.
  #  80    * Four of a Kind: Four cards of the same value.
  #  90    * Straight Flush: All cards are consecutive values of same suit.
  #  100   * Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.

sub printableCard($) {
  my $card = shift @_;
  
  return $face_map{substr($card, 0, 1)} . ' of ' . $suit_map{substr($card, 1, 1)}
}

sub isFlush($) {
  my @hand = @{shift @_};
  
  my %suits;
  
  for my $card (@hand) {
    $suits{substr($card, 1, 1)}++;
  }
  
  return (scalar(keys %suits) == 1 ? 1 : 0);
} # isFlush()

sub isStraight($) {
  my @hand = @{shift @_};
  
  my $last_card;
  my $card;
  
  for my $temp (sort @hand) {
    my $card = $face_val{substr($temp, 0, 1)};
    if ($last_card) {
      if ($card != $last_card + 1) {
        return 0;
      }
    }
    $last_card = $card;
  }
  return 1;
} # isStraight()

sub isFullHouse($) {
  my @hand = @{shift @_};
  
  my %face_cnt;
  
  map $face_cnt{substr($_, 0, 1)}++, @hand;
  
  if (scalar keys %face_cnt == 2) {
    if ($face_cnt{(keys %face_cnt)[0]} == 2 || $face_cnt{(keys %face_cnt)[0]} == 3) {
      return 1;
    } else {
      return 0;
    }
  } else {
    return 0;
  }
} # isFullHouse

sub xOfAKind($) {
  my @hand = @{shift @_};
  
  my %card_cnt;
  
  map $card_cnt{substr($_, 0, 1)}++, @hand;
  
  return $card_cnt{(reverse sort {$card_cnt{$a} <=> $card_cnt{$b}} keys %card_cnt)[0]};
  
} # xOfAKind()

sub is4ofAKind($) {
  return (xOfAKind(shift @_) == 4 ? 1 : 0);
} # is4ofAKind()

sub is3ofAKind($) {
  return (xOfAKind(shift @_) == 3 ? 1 : 0);
} # is4ofAKind()

sub isPair($) {
  return (xOfAKind(shift @_) == 2 ? 1 : 0);
} # is4ofAKind()

sub is2Pair($) {
  my @hand = @{shift @_};
  
  my %cnt;
  map $cnt{substr($_, 0, 1)}++, @hand;
  
  my $pc = 0;
  foreach my $c (keys %cnt) {
    if ($cnt{$c} == 2) {
      $pc++;
    }
  }
  
  return ($pc == 2);
} # is2Pair()

sub hasSuit($$) {
  my @hand = @{shift @_};
  my $suit = shift @_;
  
  foreach my $card (@hand) {
    if (substr($card, 1, 1) eq $suit) {
      return 1;
    }
  }
  
  return 0;
} # hasSuit()

sub hasValue($$) {
  my @hand = @{shift @_};
  my $val = shift @_;
  
  foreach my $card (@hand) {
    if (substr($card, 0, 1) eq $val) {
      return 1;
    }
  }
  
  return 0;
} # hasValue()

sub highCard($) {
  my @hand = @{shift @_};
  
  return substr((reverse sort {$face_val{substr($a, 0, 1)} <=> $face_val{substr($b, 0, 1)}} @hand)[0], 0, 1);
} # highCard()

sub getHandRank($) {
  my @hand = @{shift @_};
  
  #  10    * High Card: Highest value card.
  #  20    * One Pair: Two cards of the same value.
  #  30    * Two Pairs: Two different pairs.
  #  40    * Three of a Kind: Three cards of the same value.
  #  50    * Straight: All cards are consecutive values.
  #  60    * Flush: All cards of the same suit.
  #  70    * Full House: Three of a kind and a pair.
  #  80    * Four of a Kind: Four cards of the same value.
  #  90    * Straight Flush: All cards are consecutive values of same suit.
  #  100   * Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
  
  my $flush = isFlush(\@hand);
  my $straight = isStraight(\@hand);
  my $fullhouse = isFullHouse(\@hand);
  
  if ($flush && hasValue(\@hand, 'A')) {
    return 100;
  } elsif ($flush && $straight) {
    return 90;
  } elsif (is4ofAKind(\@hand)) {
    return 80;
  } elsif ($fullhouse) {
    return 70;
  } elsif ($flush) {
    return 60;
  } elsif ($straight) {
    return 50;
  } elsif (is3ofAKind(\@hand)) {
    return 40;
  } elsif (is2Pair(\@hand)) {
    return 30;
  } elsif (isPair(\@hand)) {
    return 20;
  } else {
    return 10;
  }
} # getHandRank()

sub highPair($) {
  my @hand = @{shift @_};
  
  my %cnts;
  map $cnts{substr($_, 0, 1)}++, @hand;
  
  
  foreach my $key(sort {$face_val{$cnts{$a}} <=> $face_val{$cnts{$b}}} keys %cnts) {
    if ($cnts{$key} == 2) {
      return $key;
    }
  }
} # highPair()

my $hands;
my $p1_wins = 0;
my $p2_wins = 0;
my $unknown_wins = 0;

my $op1 = 0;
my $op2 = 0;

my $p1hp;
my $p2hp;
my $p1hc;
my $p2hc;
my $d = '   ';
my $break_out = 0;

open (MFH, '<poker.txt') or die "Can't read hands!\n";
my $cnt = 0;
while ($hands = <MFH>) {
  chop $hands;
  chop $hands;
  @cards = split(/ /, $hands);
  @p1 = @cards[0..4];
  @p2 = @cards[5..9];
  
  my $p1s = getHandRank(\@p1);
  my $p2s = getHandRank(\@p2);  

  $p1hc = highCard(\@p1) || ' ';
  $p2hc = highCard(\@p2) || ' ';
  
  $p1hp = highPair(\@p1) || ' ';
  $p2hp = highPair(\@p2) || ' ';

  $d = '   ';
  if ($p1s == $p2s) {
    if ($p1s == 10) {
      if ($face_val{$p1hc} > $face_val{$p2hc}) {
        $p1_wins++
      } else {
        $p2_wins++;
      }
    } else {
      if ($face_val{$p1hp} == $face_val{$p2hp}) {
        $d = "$p1hc $face_val{$p1hc} == $p2hc $face_val{$p2hc}";
        if ($face_val{$p1hc} > $face_val{$p2hc}) {
          $p1_wins++;
        } else {
          $p2_wins++;
        }
      } elsif ($face_val{$p1hp} > $face_val{$p2hp}) {
        $p1_wins++;
      } else {
        $p2_wins++;
      }
    }
  } elsif ($p1s > $p2s) {
    $p1_wins++;
  } else {
    $p2_wins++;
  }
  
  $cnt++;
  
  #if ($p1s == 50 || $p1s == 90 || $p2s == 50 || $p2s == 90) {
  #if (0) { #$p1s > 20 || $p2s > 20) {
  if ($op1 != $p1_wins && $p1s == $p2s) { 
    my $p1dh = join(', ', @p1);
    my $p2dh = join(', ', @p2);
    my $winner = ($op1 != $p1_wins) ? '1' : '2';
    
    my $p1_hand = $hands{$p1s};
    my $p2_hand = $hands{$p2s};
    
    print "$cnt:$p1_wins:$p2_wins) $p1_hand ? $p2_hand = Player $winner ... " . join(', ', @p1) . ' ... ' . join(', ', @p2) . "\n";
  }
  
  $op1 = $p1_wins;
  $op2 = $p2_wins;
  
  #print "\n";
}

print <<__RESULTS;


Player 1: $p1_wins
Player 2: $p2_wins
Unknown: $unknown_wins
__RESULTS

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 376 (but I get 377 for some damned reason)