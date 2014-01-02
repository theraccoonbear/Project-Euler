#!/opt/local/bin/perl

# Project Euler Problem #59
# Each character on a computer is assigned a unique code and the preferred standard is ASCII (American Standard Code for
# Information Interchange). For example, uppercase A = 65, asterisk (*) = 42, and lowercase k = 107.
# 
# A modern encryption method is to take a text file, convert the bytes to ASCII, then XOR each byte with a given value,
# taken from a secret key. The advantage with the XOR function is that using the same encryption key on the cipher text,
# restores the plain text; for example, 65 XOR 42 = 107, then 107 XOR 42 = 65.
# 
# For unbreakable encryption, the key is the same length as the plain text message, and the key is made up of random bytes.
# The user would keep the encrypted message and the encryption key in different locations, and without both "halves", it
# is impossible to decrypt the message.
# 
# Unfortunately, this method is impractical for most users, so the modified method is to use a password as a key. If the
# password is shorter than the message, which is likely, the key is repeated cyclically throughout the message. The
# balance for this method is using a sufficiently long password key for security, but short enough to be memorable.
# 
# Your task has been made easy, as the encryption key consists of three lower case characters. Using cipher1.txt (right
# click and 'Save Link/Target As...'), a file containing the encrypted ASCII codes, and the knowledge that the plain
# text must contain common English words, decrypt the message and find the sum of the ASCII values in the original text.
# 
use strict;
use warnings;
require "functions.pm";

# Disable output buffering
select((select(STDOUT), $|=1)[0]);

startTiming();
my $answer = '';

my $data = '';
my @chars = ();
my @decrypt = ();

my ($key1, $key2, $key3);
my $i;
my $xored;
my $done = 0;

open (MFH, '<cipher1.txt') or die $!;
while (my $lod = <MFH>) {
  $data .= $lod;  
}
close MFH;

@chars = split(/,/, $data);

for ($key1 = 97; $key1 <= 122; $key1++) {
  for ($key2 = 97; $key2 <= 122; $key2++) {
    for ($key3 = 97; $key3 <= 122; $key3++) {
      for ($i = 0; $i < scalar @chars; $i += 3) {
        $decrypt[$i] = ($chars[$i] ^ $key1);
        if (defined $chars[$i + 1]) { $decrypt[$i + 1] = ($chars[$i + 1] ^ $key2); }
        if (defined $chars[$i + 2]) { $decrypt[$i + 2] = ($chars[$i + 2] ^ $key3); }
      }
      my $msg = join('', map chr($_), @decrypt);
      if ($msg =~ m/recognize/g) {
        print "$key1:$key2:$key3\n\n";
        print  $msg . "\n\n\n";
        map $answer += $_, @decrypt;
        $done = 1;
      }
    }
    if ($done) { last; }
  }
  if ($done) { last; }
}

print "\n\nAnswer: $answer\n\n";

endTiming();


# Answer: 107359