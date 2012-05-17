use XML::External;
grammar XML::Document is XML::External;
rule TOP { ^ <document> $ }

# [1] document
rule document {
	<prolog> <element> <misc>*
}

# [22] prolog
rule prolog {
	<xml_decl>? <misc>* [<doctype_decl> <misc>*]?
}

# [27] Misc
rule misc {
	| <comment>
	| <prin>
}
