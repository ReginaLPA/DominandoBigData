IMPORT $,STD;


Crimes := $.File_Crimes_2001_to_present.File;
// New layout for formatted data
new_Layout := RECORD
		UNSIGNED row_id;
		UNSIGNED6 day;
		UNSIGNED4 time;
		Crimes;
		//Crimes AND NOT date;
END;
// TRANSFORM structure and associated PROJECT function for cleansing the original dataset
New_Layout Reformatter(Crimes L, UNSIGNED cnt):=TRANSFORM
		SELF.row_id:=cnt;
		SELF.day:=(UNSIGNED6) STD.Date.FromStringToDate(L.Date[1..10],'%m/%d/%Y');
		SELF.time:=(UNSIGNED4) STD.Date.TimeFromParts
										(IF(L.Date[21..22]='PM',
										IF(L.Date[12..13]='12',12,(UNSIGNED1)L.Date[12..13]+12),
										IF(L.Date[12..13]='12',0,(UNSIGNED1)L.Date[12..13])),
								(UNSIGNED1)L.Date[15..16],
								(UNSIGNED1)L.Date[18..19]);
		SELF:=L;
END;
EXPORT UID_Crimes := PROJECT(Crimes,Reformatter(LEFT,COUNTER))
: PERSIST('~CLASS::rlp::PERSIST::UID_Crimes ');

// OUTPUT of the clean dataset
// OUTPUT(UID_Crimes,'~Class::rlp::out::UID_Crimes',overwrite);

/*
TABLE FILE VIDEOTR2
	PRINT CUSTID TRANSDATE AS 'DATE' AND COMPUTE
	TRANSDATE_DATE/YYMD = HDATE(TRANSDATE, 'YYMD');
	TRANSDATE_TIME/HMS = HDATE(TRANSDATE, 'HMS');
	DT2 = HDTTM(TRANSDATE_DATE, 8, 'HMS');
END

*/




