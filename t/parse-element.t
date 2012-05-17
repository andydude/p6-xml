use v6;
use XML::Element;

my $t = @*ARGS[0];
say $t;
say XML::Element.parse($t);