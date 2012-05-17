use v6;
use XML::Content;

my $t = @*ARGS[0];
say $t;
say XML::Content.parse($t);