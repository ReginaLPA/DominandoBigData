IMPORT $,Std; 

Layout_Accts_RecID := RECORD
UNSIGNED4 RecID := 0;
$.File_Accounts.File;
END;
AcctsTbl := TABLE($.File_Accounts.File,Layout_Accts_RecID);
Layout_Accts_RecID IDRecs(Layout_Accts_RecID L,
Layout_Accts_RecID R) := TRANSFORM
SELF.RecID := IF(L.RecID=0,std.system.thorlib.node()+1,L.RecID+CLUSTERSIZE);
SELF := R;
END;
EXPORT UID_Accounts := ITERATE(AcctsTbl,IDRecs(LEFT,RIGHT),LOCAL)
:PERSIST('~CLASS::rlp::PERSIST::UID_Accounts');