use v6;
use XML::Name;

my $t = @*ARGS[0];
say $t;
say XML::Name.parse($t);