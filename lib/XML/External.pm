use XML::Common;
grammar XML::External is XML::Common;
rule TOP {^ <ext_subset_decl> $}

# All references in this grammar are refering to:
# "Extensible Markup Language (XML) 1.0 (Fifth Edition)"
# <http://www.w3.org/TR/2008/REC-xml-20081126/>

# [6] Names
rule  names { <name>+ }

# [7] Nmtoken
token nmtoken { <.name_char>+ }

# [8] Nmtokens
rule  nmtokens { <nmtoken>+ }

# [9] EntityValue
token entity_value {
	<quotes: /<-[%&]>/, /[<pe_reference> | <reference>]/>
}

# [11] SystemLiteral
token system_literal {
	<quotes: /<?>/, /<!>/>
}

# [12] PubidLiteral
token pubid_literal {
	<quotes: /<.pubid_char>/, /<!>/>
}

# [13] PubidChar
token pubid_char {
	 <[\xA\xD\x20]+[a..zA..Z0..9]+[\-()+,./:=?;!*\#\@\$_%]>
}

# [28] doctypedecl
rule doctype_decl {
	 '<!DOCTYPE' <name> <external_id>? ['[' <int_subset> ']']? '>'
}

# [28a] DeclSep
token decl_sep {
	 <pe_reference>
}

# [28b] intSubset
token int_subset {
	[<markup_decl> | <decl_sep>]*
}

# [29] markupdecl
# This is used in <int_subset> and <ext_subset_decl>
token markup_decl {
	| <element_decl>
	| <attlist_decl>
	| <entity_decl>
	| <notation_decl>
	| <prin>
	| <comment>
}

# [30] extSubset
token ext_subset {
	 <text_decl>? <ext_subset_decl>
}

# [31] extSubsetDecl
token ext_subset_decl {
	 [ <markupdecl> | <conditional_sect> | <decl_sep>]*
}

# [45] elementdecl
rule element_decl {
	 '<!ELEMENT' <name> <content_spec> '>'
}

#token content_spec {
#	 EMPTY | ANY | <Mixed> | <children>
#}
#
#token children {
#	 [<choice> | <seq>] [? | * | +]?
#}
#
#token cp {
#	 [<name> | <choice> | <seq>] [? | * | +]?
#}
#
#token choice {
#	 ( <S>? <cp> [ <S>? | <S>? <cp> ]+ <S>? )
#}
#
#token seq {
#	 ( <S>? <cp> [ <S>? , <S>? <cp> ]* <S>? )
#}
#
#token Mixed {
#	 ( <S>? #Pcd_ATA [<S>? | <S>? <name>]* <S>? )* | ( <S>? #Pcd_ATA <S>?
#+ )
#}
#
#token Attlist_decl {
#	 <'<!ATTLIST'> <S> <name> <AttDef>* <S>? <'>'>
#}
#
#token AttDef {
#	 <S> <name> <S> <AttType> <S> <Default_decl>
#}
#
#token AttType {
#	 <StringType> | <TokenizedType> | <EnumeratedType>
#}
#
#token StringType {
#	 CDATA
#}
#
#token TokenizedType {
#	 ID| IDREF| IDREFS| ENTITY| ENTITIES| NMTOKEN| NMTOKENS
#}
#
#token EnumeratedType {
#	 <NotationType> | <Enumeration>
#}
#
#token NotationType {
#	 NOTATION <S> ( <S>? <name> [<S>? | <S>? <name>]* <S>? )
#}
#
#token Enumeration {
#	 ( <S>? <nmtoken> [<S>? | <S>? <nmtoken>]* <S>? )
#}
#
#token Default_decl {
#	 #REQUIRED | #IMPLIED | [[#FIXED <S><AttValue>]
#}
#
#token conditional_sect {
#	 <include_sect> | <ignore_sect>
#}
#
#token include_sect {
#	 <'<!['> <S><extSubset_decl> <']]>'>
#}
#
#token ignore_sect {
#	 <'<!['> <S><ignore_sect_contents>* <']]>'>
#}
#
#token ignore_sect_contents {
#	 <Ignore> [<'<!['> <ignore_sect_contents> <']]>'> <Ignore>]*
#}
#
#token Ignore {
#	 <char>* <!after [<char>* [<'<!['> | <']]>'>] <char>*]> 
#}

# [69] PEReference
token pe_reference {
	'%' <name> ';'
}

# [70] EntityDecl
token entity_decl {
	| <pe_decl>
    | <ge_decl>
}

# [71] GEDecl
rule ge_decl {
    '<!ENTITY' <name> <entity_def> '>'
}

# [72] PEDecl
rule pe_decl {
    '<!ENTITY' '%' <name> <pe_def> '>'
}

# [73] EntityDef
token entity_def {
    <entity_value> | [<external_id> <.ws> <ndata_decl>?]
}
#
## [74] PEDef
#token pe_def {
#    <entity_value> | <external_id>
#}
#
## [75] ExternalID
#rule external_id {
#	| SYSTEM <system_literal>
#	| PUBLIC <pubid_literal> <system_literal>
#}
#
#rule ndata_decl {
#	NDATA <name>
#}

# [78] extParsedEnt
token ext_parsed_ent {
    <text_decl>? <content>
}

#WTF is THIS?!?
#token ext_pe {
#    <text_decl>? <ext_subset_decl>
#}

# [82] NotationDecl
rule notation_decl {
    '<!NOTATION' <name> [<external_id> | <public_id>] '>'
}

# [83] PublicID
rule public_id {
    PUBLIC <pubid_literal>
}
