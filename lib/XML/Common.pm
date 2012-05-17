use XML::Charset;
grammar XML::Common is XML::Charset;

# All references in this grammar are refering to:
# "Extensible Markup Language (XML) 1.0 (Fifth Edition)"
# <http://www.w3.org/TR/2008/REC-xml-20081126/>

# Perl6-specific definitions
token sq { "'" }
token dq { '"' }
regex nochar ($char) { <.char> & $char }
regex quotes ($char, $ref) {
	| <.sq> ~ <.sq> [$<value> = [[<.char> & $char & <-[\']>] | $<ref> = $ref]* <?before <.sq>>]
	| <.dq> ~ <.dq> [$<value> = [[<.char> & $char & <-[\"]>] | $<ref> = $ref]* <?before <.dq>>]
}

# [10] AttValue
token value {
	<quotes: /<-[<&]>/, /<reference>/>
}

# [14] CharData
token char_data {
	<.nochar: /<-[<&]>/>*
}

# [15] Comment
regex comment {
	'<!--' ~ '-->' <char>*
}

# [16] PI
regex prin {
	'<?' [<prin_target> [<char> & <-[?]>]*] '?>'
}

# [17] PITarget
token prin_target {
	<name>
}

# [18] CD_sect
token cd_sect {
	<.cd_start> <cd_data> <.cd_end>
}

# [19] CDStart
token cd_start {
	'<![CDATA['
}

# [20] CData
regex cd_data {
#	<?after '<![CDATA['>
	<.char>*
	<?before ']]>'>
}

# [21] CDEnd
token cd_end {
	']]>'
}

# [23] XMLDecl
rule xml_decl {
	'<?xml' <version> <encoding>? <sd_decl>? '?>'
}

# [24] VersionInfo
rule version {
	version <.eq> <quotes: /<?>/, /<version_num>/>
}

# [25] Eq
# This has <S> around it in XML 1.0 but every instance of
# it appears in a rule, so whitespace is added by Perl6.
token eq { '=' }

# [26] VersionNum
token version_num { <[a..zA..Z0..9_.:\-]>+ }

# [32] SDDecl
rule sd_decl {
	standalone <.eq> <quotes: /<?>/, /[yes|no]/>
}

# [39] element
token element {
	| <empty_elem_tag>
	| <elem_tag_pair>
}
token elem_tag_pair {
	'<' <s_tag> '>' <content> '</' <e_tag> '>'
}

# [40] STag
rule s_tag {
	<name> <attribute>*
}

# [41] Attribute
rule attribute {
	<name> <.eq> <value>
}

# [42] ETag
rule e_tag {
	<name>
}

# [43] content
token content {
	<char_data>? [<contents> <char_data>?]*
}
token contents {
	| <element>
	| <cd_sect>
	| <reference>
	| <comment>
	| <prin>
}

# [44] EmptyElemTag
rule empty_elem_tag {
	'<' <name> <attribute>* '/>'
}

# [66] CharRef
token char_ref {
	| '&#x' <hexint> ';'
	| '&#' <decint> ';'
}
token decint { <.digit>+ }
token hexint { <.xdigit>+ }

# [67] Reference
token reference {
	| <char_ref>
	| <entity_ref>
}

# [68] EntityRef
token entity_ref {
	'&' <name> ';'
}

# [80] EncodingDecl
rule encoding {
	encoding <.eq> <quotes: /<?>/, /<enc_name>/>
}

# [81] EncName
token enc_name {
	<[A..Za..z]> <[A..Za..z0..9._\-]>*
}
