use XML::External;
grammar XML::ExtParsed is XML::External;
rule TOP {^ <ext_parsed_ent> $}
