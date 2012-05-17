use XML::Common;
grammar XML::Element is XML::Common;
rule TOP { ^ <element> $ }
