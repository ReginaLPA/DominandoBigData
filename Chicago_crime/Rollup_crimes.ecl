IMPORT $;

Layout_T_recs := RECORD
	UNSIGNED4 block_ID := $.Formatted_File.row_id;
	$.Formatted_File.block;
END;

	T_recs := TABLE($.Formatted_File,Layout_T_recs);
	S_recs := SORT(T_recs,block);
	S_recs;
	count(S_recs);
	

	Layout_T_recs RollCSV(Layout_T_recs L, Layout_T_recs R) := TRANSFORM
SELF.block_ID := IF(L.block_ID < R.block_ID,L.block_ID,R.block_ID);
SELF := L;
END;
Rollup_block := ROLLUP(S_Recs,
											LEFT.block=RIGHT.block,
											//AND
											//LEFT.State=RIGHT.State AND
											//LEFT.City=RIGHT.City,
											RollCSV(LEFT,RIGHT));
Rollup_block;
count(Rollup_block);
S_Rollup_block := SORT(Rollup_block,block_id);
OUTPUT(S_Rollup_block,,'~CLASS::rlp::LookupBlock',OVERWRITE);