//EXPORT BWR_Keyed := MODULE

PtblRec := RECORD
	 INTEGER8  Sequence;
	 STRING2   State;
	 STRING20  City;
	 STRING25  Lname;
	 STRING15  Fname;
	 
	 
END;

TEMP := DATASET([{3000,'FL','BOCA RATON','lONDON','BILY'},
								{35,'FL','BOCA RATON','SMITH','FRANK'},
								{50,'FL','BOCA RATON','SMITH','SUE'},
								{135,'FL','BOCA RATON','SMITH','NANCY'},
								{235,'FL','BOCA RATON','SMITH','FRED'},
								{335,'FL','BOCA RATON','TAYLOR','FRANK'},
								{3500,'FL','BOCA RATON','JONES','FRANK'},
								{30,'FL','BOCA RATON','TAYLOR',''}],PtblRec);

Proj := SORT(Temp,sequence);

DataFile := '~BFTEMP::TestKeyedJoin';
KeyFile1 := '~BFTEMP::lname,lnameKey';
KeyFile2 := '~BFTEMP::lname,lnameKeyPay';
KeyFile3 := '~BFTEMP::SequenceKey';
KeyFile4 := '~BFTEMP::SequenceKeyPay';

PtblOut    := OUTPUT(Proj,,DataFile, OVERWrITE);
PtbllPlus  := DATASET(DataFile,
								{PtblRec,UNSIGNED8 recpos{VIRTUAL(fileposition)}},FLAT);

Ptbl2      := DATASET(DataFile,PtblRec,FLAT);

AlphaKey   := INDEX(PtbllPlus,{lname,fname,recpos}, KeyFile1);
AlphaPay   := INDEX(Ptbl2,{lname,fname}, {Ptbl2},KeyFile2); //payload

Bld1       := BUILD(AlphaKey, OVERWRITE);
Bld2       := BUILD(AlphaPay, OVERWRITE);

SequenceKey := INDEX(PtbllPlus,{sequence,recpos}, KeyFile3);
SequencePay := INDEX(Ptbl2,{sequence},{Ptbl2}, KeyFile4); //payload
Bld3        := BUILD(SequenceKey, OVERWRITE);
Bld4        := BUILD(SequencePay, OVERWRITE);

peopleRecord  := RECORD
	INTEGER8    id;
	STRING20    lastname;
END;


peopleDataset  := DATASET([{3000,'LONDON'},
								{3500,'SMITH'},
								{30,'TAYLOR'}],peopleRecord);
								

joinedRecord := RECORD
	PtblRec;
	peopleRecord AND NOT [id];
END;

joinedRecord doJoin(peopleRecord L, PtbllPlus R)  := TRANSFORM
	SELF := L;
	SELF := R;
END;

FilledRecs1  := JOIN(peopleDataset, PtbllPlus,
										LEFT.id=RIGHT.sequence,
										doJoin(LEFT,RIGHT), KEYED(SequenceKey)); //Full Keyed
										
										
FilledRecs2  := JOIN(peopleDataset, PtbllPlus,
										LEFT.lastname=RIGHT.Lname,
										doJoin(LEFT,RIGHT), KEYED(AlphaKey)); //FullKeye


FilledRecs3  := JOIN(peopleDataset, SequencePay,
										LEFT.id=RIGHT.sequence,
										TRANSFORM(joinedRecord, SELF  := LEFT,SELF := RIGHT)); //HALF-KEYED
										//doJoin(LEFT,RIGHT));


FilledRecs4  := JOIN(peopleDataset, AlphaPay,
										LEFT.lastname=RIGHT.Lname,
										TRANSFORM(joinedRecord, SELF  := LEFT,SELF := RIGHT)); //HALF-KEYED
										
out1 := OUTPUT(FilledRecs1,NAMED('FULLKEYRecs1'));
out2 := OUTPUT(FilledRecs2,NAMED('FULLKEYRecs2'));
out3 := OUTPUT(FilledRecs3,NAMED('HALFKEYRecs3'));
out4 := OUTPUT(FilledRecs4,NAMED('HALFKEYRecs4'));


SEQUENTIAL(PtblOut,
						PARALLEL(Bld1,Bld2,Bld3,Bld4),
						PARALLEL(out1,out2,out3,out4));
								
								


	 

