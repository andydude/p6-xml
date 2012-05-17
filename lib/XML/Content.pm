use XML::Common;
grammar XML::Content is XML::Common;
rule TOP { ^ <content> $ }
