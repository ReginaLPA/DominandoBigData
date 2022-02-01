IMPORT $, STD;
 #OPTION('outputLimit',100);
crime := $.File_crime_raw.File;
crimes:=$.File_crime_optimized.File;

//OUTPUT(Crimes, NAMED('Crimes'));

STD.DataPAtterns.PRofile($.File_crime_raw.File);

// OUTPUT($.File_crime_optimized.File,NAMED('Optimized_data'));

// OUTPUT($.Formatted_File,NAMED('Formatado'));
formt := $.Formatted_File;
// OUTPUT($.NormAddrRecs.File,NAMED('Enderecos'));
// OUTPUT($.NormCrimeRecs.File,NAMED('Crimes'));

// BUILD($.NormAddrRecs.IDX_Addr,OVERWRITE);
// BUILD($.NormCrimeRecs.IDX_Crimes,OVERWRITE);

//count(formt);
//COUNT(formt(year[..4] > 2000));//687
//$.CrimeBlockSvc('E 100 PL');