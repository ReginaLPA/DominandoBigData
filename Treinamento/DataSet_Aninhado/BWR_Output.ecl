//EXPORT BWR_Output := 'todo';

ParentRec := {INTEGER1 NameID, STRING20 Name};

ParentTable := DATASET(
		[{1,'Kevin'},{2,'Liz'},
		{3,'Mr Nobody'},{4,'Anywhere'}], ParentRec);
		ChildRec := {INTEGER1 NameID, STRING20 Addr};
		
ChildTable := DATASET([ {1,'10 Malt Lane'},{2,'10 Malt Lane'},
											{2,'3 The cottages'},{4,'Here'},{4,'There'},
											{4,'Near'},{4,'Far'}],ChildRec);
DenormedRec := RECORD
		INTEGER1 NameID;
		STRING20 Name;
		UNSIGNED1 NumRows;
		DATASET(ChildRec) Children;
		// ChildRec Children; //alternative syntax
		END;
DenormedRec ParentMove(ParentRec L) := TRANSFORM
		SELF.NumRows := 0;
		SELF.Children := [];
		SELF := L;
		END;
ParentOnly := PROJECT(ParentTable, ParentMove(LEFT));

		DenormedRec ChildMove(DenormedRec L,ChildRec R,INTEGER C):=TRANSFORM
		SELF.NumRows := C;
		SELF.Children := L.Children + R;
		SELF := L;
		END;
DeNormedRecs := DENORMALIZE(ParentOnly, ChildTable,
		LEFT.NameID = RIGHT.NameID,
		ChildMove(LEFT,RIGHT,COUNTER));
OUTPUT(DeNormedRecs,,'RTTEMP::TestChildDatasets');
// Using inline DATASET in a TRANSFORM to initialize child records
AkaRec := {STRING20 forename,STRING20 surname};
outputRec := RECORD
	UNSIGNED id;
	DATASET(AkaRec) children;
	END;
inputRec := RECORD
	UNSIGNED id;
	STRING20 forename;
	STRING20 surname;
	END;