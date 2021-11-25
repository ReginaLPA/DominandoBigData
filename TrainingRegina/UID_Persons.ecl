IMPORT $;

Myrec := RECORD
	UNSIGNED4 RecID;
	$.File_Persons.File;
END;
 Myrec  IDRecs($.File_Persons.File L,INTEGER C) := TRANSFORM
	SELF.RecID := C;
	SELF := L;
END;
EXPORT UID_Persons := PROJECT($.File_Persons.File,IDRecs(LEFT,COUNTER))
: PERSIST('~CLASS::rlp::PERSIST::UID_Persons');



