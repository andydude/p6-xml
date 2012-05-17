use XML::External;
grammar XML::IntSubset is XML::External;
rule TOP {^ <int_subset> $}
