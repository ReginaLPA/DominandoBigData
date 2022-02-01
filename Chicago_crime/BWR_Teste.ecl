
IMPORT $;

IMPORT STD;
//Essa ? a forma mais simples de relat?rio crosstab, com um ?nico campo "group by"

r := RECORD
$.Formatted_File.year;
$.Formatted_File.Primary_Type;
//$.Formatted_File.Block;
$.Formatted_File.Location;
$.Formatted_File.Location_Description;
INTEGER cnt := COUNT(GROUP);
END;
//EXPORT XTAB_Persons_Gender := TABLE($.Formatted_File,r,-year);
XTAB_Persons_Gender := TABLE($.Formatted_File,r,-year);
sort(XTAB_Persons_Gender,cnt);


layout_min_max := RECORD
Min_Value := MIN(GROUP,XTAB_Persons_Gender.cnt);
Max_Value := MAX(GROUP,XTAB_Persons_Gender.cnt);
END;


//EXPORT XTAB_Accounts_HighCredit_MaxMin := TABLE($.File_Accounts.File, layout_min_max);
XTAB_Accounts_HighCredit_MaxMin := TABLE(XTAB_Persons_Gender, layout_min_max);
XTAB_Accounts_HighCredit_MaxMin;
//A chave deste relat?rio crosstab ? a falta de campos "group by" na fun??o TABLE ou na estrutura RECORD.




dtm := STD.Date.TimeZone.ToLocalTime(205246,'CST','NORTH AMERICA');
//dtm
D1 := STD.Date.DayOfYear(STD.Date.Today());
//D1
// hor := STD.Date.TimeZone.ToUTCTime(205246,'CST','NORTH AMERICA');
// hor
 // crimes := $.File_crime_optimized.File;
// OUTPUT(crimes);
// OUTPUT($.File_crime_optimized.File,NAMED('Optimized_data'));
// crimes_id := crimes,{id,HASH64(id)});

// Myrec := RECORD 
  	// UNSIGNED id := {id,HASH64(id)};
		// crimes;
// END;


// MyTable := SORT(TABLE(crimes,MyRec),id);
// OUTPUT(MyTAble);


 // t := TABLE($.File_crime_optimized.File,
	// {$.File_crime_optimized.File.id});
	// dt :=DISTRIBUTE(crimes,HASH64(id));
	// sdt := SORT(dt,id,LOCAL);
	// dsdt := DEDUP(sdt,id,LOCAL);

// OUTPUT(dt, NAMED('id'));
// OUTPUT(sdt,NAMED('id_ordenado'));
// OUTPUT(t,NAMED('Daset_Id_Hash'));
// COUNT(dsdt);
// OUTPUT(t,,'~class::rla::teste',OVERWRITE);

// OUTPUT(crimes,{id,HASH64(id)});


/*
new_Layout := RECORD
	UNSIGNED row_id;
	UNSIGNED4 day;
	UNSIGNED id;
	//STRING6 time;
	UNSIGNED4 time;
	//Crimes AND NOT date;
END;

// TRANSFORM structure and associated PROJECT function for cleansing the original dataset
New_Layout Reformatter(Crimes L, UNSIGNED cnt):=TRANSFORM
		SELF.row_id:=cnt;
		SELF.id:= {id,HASH64(id)}
		SELF.day:=STD.Date.FromStringToDate(L.Date[1..10],'%m/%d/%Y');
		// SELF.time:=INTFORMAT(STD.Date.TimeFromParts(IF(L.Date[21..22]='PM',
		SELF.time:=STD.Date.TimeFromParts(IF(L.Date[21..22]='PM',
																			                       IF(L.Date[12..13]='12',12,(UNSIGNED1)L.Date[12..13]+12),
																					                   IF(L.Date[12..13]='12',0,(UNSIGNED1)L.Date[12..13])),
																			(UNSIGNED1)L.Date[15..16],
																			// (UNSIGNED1)L.Date[18..19]),6,1);
																			(UNSIGNED1)L.Date[18..19]);
		SELF:=L;
END;

EXPORT Formatted_File := PROJECT(Crimes.File,Reformatter(LEFT,COUNTER)):PERSIST('~class::rlp::out::Formatted_file');
*/