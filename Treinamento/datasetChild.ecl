ChildRec := RECORD
 unsigned per_id;
 string20 per_surname;
 string20 per_forname;
END;

ParentRec := RECORD
    unsigned8 id;
    string20 address;  
    unsigned8 NumkIDS; 
    string20 postcode;  
    DATASET(ChildRec)Children;//{MAXCOUNT(100)};    
END;

ParentTable := DATASET([{1,'10 Malt Lane',234,'13031605'},
                        {2,'10 Malt Lane',122,'15246333'},
                        {2,'3 The cottages',45,'13056987'},
                        {4,'Here',896,'12548796'},
                        {4,'There',658,'1352879'},
                        {4,'Near',578,'1369896'},
                        {4,'Far',898,'15487963'}],ParentRec);

ChildTable := DATASET([{1,'Kevin','Batista'},
                        {2,'Liz','Amorin'},
                        {3,'Mr Nobody','Araujo'},
                        {4,'Anywhere','Tavares'}], ChildRec);
OUTPUT(ChildTable);
OUTPUT(ParentTable);



