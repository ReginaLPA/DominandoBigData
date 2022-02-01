//EXPORT Join_Crimes := 'todo';
IMPORT $;
 $.NormCrimeRecs.Layout Slimdown(RECORDOF($.Formatted_File) L,
																	$.NormAddrRecs.Layout R) := TRANSFORM																	
		SELF.block_ID := R.block_ID;
		SELF := L;
	END;
	
	SlimREcs := JOIN($.Formatted_File,$.NormAddrRecs.File,
							LEFT.block=RIGHT.block,
							Slimdown(LEFT,RIGHT));//LEFt OUTER,LOCKUP

OUTPUT(SlimRecs,,'~CLASS::rlp::OUT::Crimes_Slim',OVERWRITE);