#!/opt/local/bin/perl
use List::Util qw[min max reduce];
use List::MoreUtils qw[uniq];
#use Time::HiRes qw( usleep ualarm gettimeofday tv_interval nanosleep clock_gettime clock_getres clock_nanosleep clock stat);


sub primeFactorization($);
sub roundup($);
sub loadPrimes();
sub isPrime($);
sub factors($);
sub primes($);
sub startTiming();
sub endTiming();
sub dbgMsg($);
sub debugOn();
sub debugOff();
sub bigAdd($$);
sub bigMult($$);
sub bigExp($$);
sub bigFac($);
sub daysInMonth($$);
sub monthName($);
sub sumArray($);
sub properDivisors($);
sub bigFib($);
sub rule();
sub factorial($);
sub isPandigital($);
sub tick($);
sub permute($$);
sub arePermutations($$);
sub normalizedPermutation($);
sub triNum($);
sub squareNum($);
sub pentNum($);
sub hexNum($);
sub heptNum($);
sub octNum($);
sub isPalindrome($);
sub isLychrel($);
sub isPowerOf($$);
sub getContFracSeq($);
sub gcd($$);


my $start_time = 0;
my $end_time = 0;
my $debugging = 1;
my @big_fib_memo = ();

my @prime_memo = ();
my %ht_prime_memo = {};
my @ri_prime_memo = ();
my $largest_prime = 0;
my %fact_memo;
my @progressChars = ('|','/','-','\\');
my $current = 0;


sub debugOn() {
  $debugging = 1;
} # debugOn();

sub debugOff() {
  $debugging = 0;
} # debugOff()

sub dbgMsg($) {
  my $msg = shift @_;
  if ($debugging) {
    print $msg;
  }
} # dbgMsg()

sub startTiming() {
  print "Timing started....\n\n";
  $start_time = time;
} # startTiming()

sub endTiming() {
  $end_time = time;
  print "\n\n" . ($end_time - $start_time) . " second(s) elapsed.\n\n";
  return $end_time - $start_time;
  exit 0;
} # endTiming()

sub primeFactorization($) {
  my $val = shift @_;
  
  my $prime_factors;
  my @primes = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997, 1009, 1013, 1019, 1021, 1031, 1033, 1039, 1049, 1051, 1061, 1063, 1069, 1087, 1091, 1093, 1097, 1103, 1109, 1117, 1123, 1129, 1151, 1153, 1163, 1171, 1181, 1187, 1193, 1201, 1213, 1217, 1223, 1229, 1231, 1237, 1249, 1259, 1277, 1279, 1283, 1289, 1291, 1297, 1301, 1303, 1307, 1319, 1321, 1327, 1361, 1367, 1373, 1381, 1399, 1409, 1423, 1427, 1429, 1433, 1439, 1447, 1451, 1453, 1459, 1471, 1481, 1483, 1487, 1489, 1493, 1499, 1511, 1523, 1531, 1543, 1549, 1553, 1559, 1567, 1571, 1579, 1583, 1597, 1601, 1607, 1609, 1613, 1619, 1621, 1627, 1637, 1657, 1663, 1667, 1669, 1693, 1697, 1699, 1709, 1721, 1723, 1733, 1741, 1747, 1753, 1759, 1777, 1783, 1787, 1789, 1801, 1811, 1823, 1831, 1847, 1861, 1867, 1871, 1873, 1877, 1879, 1889, 1901, 1907, 1913, 1931, 1933, 1949, 1951, 1973, 1979, 1987, 1993, 1997, 1999, 2003, 2011, 2017, 2027, 2029, 2039, 2053, 2063, 2069, 2081, 2083, 2087, 2089, 2099, 2111, 2113, 2129, 2131, 2137, 2141, 2143, 2153, 2161, 2179, 2203, 2207, 2213, 2221, 2237, 2239, 2243, 2251, 2267, 2269, 2273, 2281, 2287, 2293, 2297, 2309, 2311, 2333, 2339, 2341, 2347, 2351, 2357, 2371, 2377, 2381, 2383, 2389, 2393, 2399, 2411, 2417, 2423, 2437, 2441, 2447, 2459, 2467, 2473, 2477, 2503, 2521, 2531, 2539, 2543, 2549, 2551, 2557, 2579, 2591, 2593, 2609, 2617, 2621, 2633, 2647, 2657, 2659, 2663, 2671, 2677, 2683, 2687, 2689, 2693, 2699, 2707, 2711, 2713, 2719, 2729, 2731, 2741, 2749, 2753, 2767, 2777, 2789, 2791, 2797, 2801, 2803, 2819, 2833, 2837, 2843, 2851, 2857, 2861, 2879, 2887, 2897, 2903, 2909, 2917, 2927, 2939, 2953, 2957, 2963, 2969, 2971, 2999, 3001);
  
  
  @{$prime_factors} = ();
  
  for (my $x = 0; $x < $#primes; $x++) {
    while ($val % $primes[$x] == 0) {
      push @{$prime_factors}, $primes[$x];
      $val = $val / $primes[$x];
    }
    if ($val == 0 || $primes[$x] > $val) {
      last;
    }
  }
  
  return $prime_factors;
} # primeFactorization()

sub roundup($) {
  my $n = shift;
  return(($n == int($n)) ? $n : int($n + 1))
} # roundup()

sub loadedPrimes() {
  my $what = shift @_;
  
  if (! $ht_prime_memo{2}) {
    loadPrimes();
  }
  #return sort {$a <=> $b} %ht_prime_memo;
  
  return (defined $what && $what eq 'array') ? @ri_prime_memo : %ht_prime_memo;
} # loadedPrimes()

sub loadPrimes() {
  open (MFH, "/Users/don/bin/scripts/euler/primes-1_000_000.txt") or die "Can't load list of primes -- $!";
  dbgMsg("No prime table loaded.\n");
  while (my $lod = <MFH>) {
    $lod =~ s/^\s*(.+?)\s*$/$1/gi;
    my @spl = split(/\s+/, $lod);
    foreach $prime (@spl) {
      $ht_prime_memo{$prime} = 1;
      push @ri_prime_memo, $prime;
      if (scalar(@ri_prime_memo) % 10000 == 0) { tick('Loading primes...'); }
      $largest_prime = $prime;
    }
    
  }
  close MFH;
  dbgMsg("\n..." . scalar(keys %ht_prime_memo) . " primes loaded.\n");
} # loadPrimes();

sub isPrime($) {
  my $val = shift @_;
  
  if (! $ht_prime_memo{2}) {
    loadPrimes();
  }
  
  if ($val > $largest_prime) {
    #dbgMsg("Prime check on $val\n");
    
    my $sqrt_val = roundup(sqrt $val);
    
    for (my $i = 2; $i <= $sqrt_val; $i++) {
      if ($val % $i == 0) {
        #$prime_memo[$val] = 0;
        $ht_prime_memo{$val} = 0;
        last;
      }
    }
    
    if (defined $ht_prime_memo{$val}) {
      return $ht_prime_memo{$val};
    } else {
      return 1;
    }
  } else {
    return (defined $ht_prime_memo{$val} && $ht_prime_memo{$val} == 1) ? 1 : 0;
  }
} # isPrime()

sub _isPrime($) {
  my $val = shift @_;
  
  if (! defined $prime_memo[$val]) {
    $prime_memo[$val] = 1;
    if ($val == 2) {
      $prime_memo[$val] = 0;
    } else {
      if ($val =~ m/(\d[024568])$/) {
        $prime_memo[$val] = 0;
      } else {
        my $sqrt_val = roundup(sqrt $val);
        
        for (my $i = 2; $i <= $sqrt_val; $i++) {
          if ($val % $i == 0) {
            $prime_memo[$val] = 0;
            last;
          }
        }
      }
    }
  }
  return $prime_memo[$val];  
} # isPrime()

sub factors($) {
  my $val = shift @_;
  my $sqrt_val = roundup(sqrt $val);
  
  my $f;
  @{$f} = ();
  
  for (my $i = 1; $i <= $sqrt_val; $i++) {
    if ($val % $i == 0) {
      push @{$f}, $i;
      push @{$f}, $val / $i;
    }
  }
  
  return $f;
} # factors()

sub primes($) {
  my $limit = shift @_;
  
  my $primes;
  
  @{$primes} = ();
  
  $primes->[1..$limit] = 0;
  
  my %pr;
  
  dbgMsg("\nGenerating primes from 2 to $limit, inclusive ");
  
  for (my $x = 2; $x <= $limit; $x++) {
    if ((defined $primes->[$x] && $primes->[$x]) || isPrime($x)) {
      for (my $m = 2; $m * $x <= $limit; $m++) {
        $primes->[$m * $x] = 0;
      }
      $primes->[$x] = 1;
    } else {
      $primes->[$x] = 0;
    }
    
    if ($x % ($limit / 1000) == 0) { dbgMsg('.'); }
  }
  
  dbgMsg("\n...Done!\n");
  return $primes;
  
} # primes()

sub bigAdd($$) {
  my $num1 = shift @_;
  my $num2 = shift @_;
  my $carry = 0;
  my $init = max(length($num1), length($num2));
  my $sum = 0;
  my $result = '';
  my $digit;
  my $digit1;
  my $digit2; 
  
  dbgMsg("$num1 + $num2 = ...\n");

  for (my $i = 1; $i <= $init; $i++) {
    $digit1 = $i <= length($num1) ? substr($num1, -$i, 1) : 0;
    $digit2 = $i <= length($num2) ? substr($num2, -$i, 1) : 0;
    $sum = $digit1 + $digit2 + $carry;
    
    dbgMsg("    $digit1 + $digit2 + $carry = $sum\n");
    
    if ($sum > 9) {
      $digit = int(substr($sum, -1, 1));
      $carry = ($sum - $digit) / 10;
      #dbgMsg("SUM: $sum, DIGIT: $digit, CARRY: $carry\n");
    } else {
      $carry = 0;
      $digit = $sum;
    }
    $result = $digit . $result;
    dbgMsg("-> $result\n");
  }
  
  if ($carry > 0) {
    $result = $carry . $result;
  }
  
  return $result;
} # bigAdd()

sub bigMult($$) {
  my $num1 = shift @_;
  my $num2 = shift @_;
  my $result = 0;
  
  if ($num1 > $num2) {
    ($num1, $num2) = ($num2, $num1);
  }
  
  for (my $i = 0; $i < $num1; $i++) {
    #dbgMsg("$result + $num2 = ");
    $result = bigAdd($result, $num2);
    #dbgMsg("$result\n");
  }
  
  return $result;
} # bigMult()

sub bigDiv($$) {
  my $numerator = shift @_;
  my $denominator = shift @_;
  
  #dbgMsg("Num: $numerator, Den: $denominator\n\n");
  
  my $i = 1;
  my $i_denom = substr($denominator, 0, $x);
  
  while (int($i_denom) < int($numerator)) {
    print "$i :: $numerator / $i_denom\n\n";
    
    $i++;
    $i_denom = substr($denominator, 0, $x);
  }
  
  
} # bigDiv()

sub _bigDiv($$) {
  my $dividend = shift @_;
  my $divisor = shift @_;
  my $i = 1;
  my $i_dividend = 1000000;
  my $quotient = '';
  my $mult = 0;
  
  print "Solving $dividend / $divisor\n\n";
  
  my $check = int(substr($dividend, 0, $i));
  print "($i:" . length($dividend) .") $check < $divisor : $quotient\n";
  
  while ($check < $divisor) {  
    $i++;
    if ($i == length($dividend) - 1) {
      $quotient = '0.';
      $check = $check . '0';
    } elsif ($i > length($dividend)) {
      if ($quotient !~ m/\./gi) {
        $quotient .= '0.';
      } else {
        $quotient .= '0';
      }
      $check = $check . '0'
    } else {
      $check = int(substr($dividend, 0, $i));
    }
    print "($i:" . length($dividend) .") $check < $divisor : $quotient\n";
  }
  
  #     ___9_____
  # 34 | 3294322
  #    - 306
  #       234
  
  $i_dividend = $check; #substr($dividend, 0, $i);
  
  my $x = $i + 1;
  my $precision = 0;
  
  #if ($x > length($dividend)) {
  #  $quotient .= '0.' . '0' x (length($dividend) - $x);
  #}
  
  #for (my $x = $i + 1; $x <= length($dividend); $x++) {
  while ($i_dividend != 0 && $precision < 10) {
    $mult = int($i_dividend / $divisor);
    $quotient .= $mult;
    if ($x > length($dividend)) {
      $i_dividend = ($i_dividend - ($divisor * $mult)) . '0';
      $precision++;
    } else {
      if ($x == length($dividend)) {
        $quotient .= '.';
      }
      #print "$i_dividend - " . ($divisor * $mult . " = ");
      
      $i_dividend = ($i_dividend - ($divisor * $mult)) . substr($dividend, $x, 1);
      
      #print "$i_dividend\n";
    }
    $x++;
  }
  $mult = int($i_dividend / $divisor);
  $quotient .= $mult;
  $i_dividend = ($i_dividend - ($divisor * $mult)) . substr($dividend, $x, 1);
  
  
  return $quotient
  
} # bigDiv()

sub bigExp($$) {
  my $num1 = shift @_;
  my $num2 = shift @_;
  my $result = 1;
  
  for (my $i = 0; $i < $num2; $i++) {
    $result = bigMult($result, $num1);
  }
  
  return $result;
} # bigExp()

sub bigFac($) {
  my $val = shift @_;
  
  if ($val == 1) {
    return 1;
  } else {
    return bigMult($val, bigFac($val - 1));
  }
} # bigFac()

sub bigFib($) {
  my $val = shift @_;
  
  if (defined $big_fib_memo[$val]) {
    return $big_fib_memo[$val];
  } elsif ($val == 0) {
    $big_fib_memo[$val] = 0;
    return 0;
  } elsif ($val == 1 || $val == 2) {
    $big_fib_memo[$val] = 1;
    return 1;
  } else {
    $big_fib_memo[$val] = bigAdd(bigFib($val - 1), bigFib($val - 2));
    return $big_fib_memo[$val];
  }
} # bigFib()

sub daysInMonth($$) {
  my $month = shift @_;
  my $year = shift @_;
  
  $DOM[1] = 31;
  $DOM[2] = ($year % 4 == 0) ? ($year % 100 == 0) ? ($year % 400 == 0) ? 29 : 28 : 29 : 28;
  $DOM[3] = 31;
  $DOM[4] = 30;
  $DOM[5] = 30;
  $DOM[6] = 31;
  $DOM[7] = 31;
  $DOM[8] = 31;
  $DOM[9] = 30;
  $DOM[10] = 31;
  $DOM[11] = 30;
  $DOM[12] = 31;
  
  if ($month < 1 || $month > 12) {
    return 0;
  } else {
    return $DOM[$month];
  }
  
} # daysInMonth()

sub monthName($) {
  my $month = shift @_;
  
  $MNAME[1] = 'January';
  $MNAME[2] = 'February';
  $MNAME[3] = 'March';
  $MNAME[4] = 'April';
  $MNAME[5] = 'May';
  $MNAME[6] = 'June';
  $MNAME[7] = 'July';
  $MNAME[8] = 'August';
  $MNAME[9] = 'September';
  $MNAME[10] = 'October';
  $MNAME[11] = 'November';
  $MNAME[12] = 'December';
  
  if ($month < 1 || $month > 12) {
    return '';
  } else {
    return $MNAME[$month];
  }
  
} # monthName()

sub sumArray($) {
  my @ar = @_;
  
  return reduce {$a + $b} @ar;
} # sumArray()

sub properDivisors($) {
  my $val = shift @_;
  my $sqrt_val = roundup(sqrt $val);
  my @divisors = (1);
    
  if ($val == 2) { return (1); }
    
  for (my $x = 2; $x <= $sqrt_val; $x++) {
    if ($val % $x == 0) {
      push @divisors, ($x , $val / $x);
    }
  }
  
  return sort {$a <=> $b} (uniq @divisors);
} # properDivisors()

sub rule() {
  print '-=' x 80 . "\n";
} #rule()

sub factorial($) {
  my $val = shift @_;
  
  if ($val == 0) { return 1; }
  
  if (defined $fact_memo{$val}) {
    return $fact_memo{$val};
  }
  
  my $t = 1;
  for (my $x = $val; $x > 1; $x--) {
    if (defined $fact_memo{$x}) {
      $t *= $fact_memo{$x};
      last;
    } else {
      $t *= $x;
    }
  }
  
  $fact_memo{$val} = $t;
  
  return $t;
} # factorial()

sub _isPandigital($) {
  my $val = shift @_;
  
  return($val =~ m/1/ &&
         $val =~ m/2/ &&
         $val =~ m/3/ &&
         $val =~ m/4/ &&
         $val =~ m/5/ &&
         $val =~ m/6/ &&
         $val =~ m/7/ &&
         $val =~ m/8/ &&
         $val =~ m/9/);
} # isPandigital()

sub __isPandigital($) {
  my $val = shift(@_);
  
  for (my $x = 1; $x <= length($val); $x++) {
    if ($val !~ m/$x/) {
      return 0;
    }
  }
  
  return 1;
} # isPandigital()

sub isPandigital($) {
  my $val = shift @_;
  my $check_val = '123456789';
  if (length($val) > 9) { $check_val = '0123456789'; }
  $val = join('', sort split(//, $val));
  return ($val eq substr($check_val, 0, length($val)));
}

sub tick($){
  my $value = shift @_;
  $current = ++$current % 4;
  print "\r$progressChars[$current] -- $value ";
}

my $pcd = 0;

sub permute($$) {
  my @v = @{shift @_};
  my @c = @{shift @_};
  my @intc = ();

  
  for (my $i = 0; $i < scalar @v; $i++) {
    my $sv = $v[$i];
    push @c, $sv;
    
    $pcd++;
    if ($pcd  % 20000 == 0) { tick(''); }
    
    if ($#v > 0) {
      my @ta  = @v;
      splice(@ta, $i, 1);
      
      push @intc, permute(\@ta, \@c);
      pop @c;
    } else {
      push @intc, \@c;
    }
  }
  return @intc;
} # permute()

sub arePermutations($$) {
  my $num1 = shift @_;
  my $num2 = shift @_;
  
  return (join('', (sort split(//, $num1))) eq join('', (sort split(//, $num2))))
} # arePermutations

sub normalizedPermutation($) {
  return join('', (sort split(//, shift @_)))
} # normalizedPermutation()

sub triNum($) {
  my $n = shift @_;
  return $n * ($n + 1) / 2;
} # triNum()

sub squareNum($) {
  my $n = shift @_;
  return $n ** 2;
} # squareNum()

sub pentNum($) {
  my $n = shift @_;
  return $n * (3 * $n - 1) / 2;
} # pentNum()

sub hexNum($) {
  my $n = shift @_;
  return $n * (2 * $n - 1);
} # hexNum()

sub heptNum($) {
  my $n = shift @_;
  return $n * (5 * $n - 3) / 2;
} # heptNum()

sub octNum($) {
  my $n = shift @_;
  return $n * (3 * $n - 2);
} # octNum()
 
sub isPalindrome($) {
  my $val = shift @_;
  my $len = length $val;
  
  for (my $i = 0; $i < $len / 2; $i++) {
    if (substr($val, $i, 1) ne substr($val, $len - $i - 1, 1)) {
      return 0;
    }
  }
  
  return 1;
} # isPalindrome()

sub isLychrel($) {
  my $num = shift @_;
  my $onum = $num;
  my $rev = int(join('', reverse split(//, $num)));
  
  for (my $cnt = 1; $cnt < 51; $cnt++) {
    my $new = bigAdd($num, $rev);
    if (isPalindrome($new)) {
      return $cnt;
    }
    $num = $new;
    $rev = int(join('', reverse split(//, $num)));
  }
  return 0;
} # isLychrel

sub isPowerOf($$) {
  my $num = shift @_;
  my $power = shift @_;
  
  my $val = $num ** (1/$power);
  my $int_val;
  ($int_val = $val) =~ s/^(\d+).*?$/\1/gi;
  return ($int_val eq $val ? 1 : 0);
} # isPowerOf()

sub getContFracSeq($) {
  my $n = shift @_;
  my $orig = $n;
  
  my @cf;
  my $m = floor(sqrt($n));
  my $cont = 1;
  my $cnt = 0;
  my $mult = 1;
  my $cfd = 3;
  my $nd = 1;
 
  push @cf, $m;
  
  while ($cont) {
    $nd = ($orig - ($m ** 2)) / $mult;
    $cfd = int((sqrt($orig) + $m) / $nd);
    $mult = $nd;
    
    push @cf, $cfd;
    $m = -($m - ($nd * $cfd)); #$m - $cfd;
    
    if ($nd == 1) { $cont = 0; }
  }
  
  return @cf;
} # getContFracSeq

sub gcd($$) {
  my $num1 = shift @_;
  my $num2 = shift @_;
  
  my @pf1 = sort @{primeFactorization($num1)};
  my @pf2 = sort @{primeFactorization($num2)};
  
  #print join(', ', @pf1) . "\n";
  #print join(', ', @pf2) . "\n";
  
  my $gcd = 1;
  
  for (my $i1 = 0; $i1 <= $#pf1; $i1++) {
    for (my $i2 = 0; $i2 <= $#pf2; $i2++) {
      if ($pf1[$i1] == $pf2[$i2]) {
        #print "gcd = $gcd * $pf1[$i1]\n";
        $gcd *= $pf1[$i1];
        delete $pf2[$i2];
        last;
      }
    }
  }
  
  return $gcd;
} # gcd()

1;
