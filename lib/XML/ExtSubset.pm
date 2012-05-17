use XML::External;
grammar XML::ExtSubset is XML::External;
rule TOP {^ <ext_subset> $}
