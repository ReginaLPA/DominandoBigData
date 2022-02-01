IMPORT $;
EXPORT NormAddrRecs := MODULE
  EXPORT Layout := RECORD
    UNSIGNED4 block_ID;
		STRING38 Block;
  END;
  EXPORT File := DATASET('~CLASS::rlp::LookupBlock',Layout,THOR);
	EXPORT IDX_Addr := INDEX(File,{Block},{block_ID},'~class::rlp::key::addr_block');
END;