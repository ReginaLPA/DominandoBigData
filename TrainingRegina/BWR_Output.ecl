IMPORT TrainingRegina, STD;
#WORKUNIT('name','Global (non-local processing)');
//Aula 2
//OUTPUT(TrainingRegina.File_Crimes_2001_to_present.File);
//OUTPUT('Hello Wolrd!');

//OUTPUT(TrainingRegina.File_Accounts.File);
//OUTPUT(TrainingRegina.File_Persons.File);
//OUTPUT(TrainingRegina.File_Persons.File,{FirstName, LastName}, NAMED('Names_Only'));


Accounts := TrainingRegina.File_Accounts.File;
//OUTPUT(Accounts,  NAMED('Accounts'));
Persons := TrainingRegina.File_Persons.File;
//OUTPUT(Persons, NAMED('Persons'));
Crimes := TrainingRegina.File_Crimes_2001_to_present.File;
//OUTPUT(Crimes, NAMED('Crimes'));
// Aula 3 - Renomeando dataset´s
//profile := STD.DataPatterns.Profile(Persons);
//OUTPUT(profile);
//benford := STD.DataPattersns.Benford(Persons,'zipcode');
//benford := STD.DataPatterns.Benford(Accounts,'balance');
//OUTPUT(benford);

profile := STD.DataPatterns.Profile(Crimes);
//OUTPUT(profile);

/*MalePersons := Persons(Gender='M',City='MIAMI');
MalePersons := Persons(Gender='M'AND NOT City='MIAMI');
MalePersonsCount := COUNT(MalePersons);
OUTPUT(MalePersons);
OUTPUT(MalePersonsCount);

OUTPUT(COUNT(Persons));
OUTPUT(COUNT(Accounts));
OUTPUT(Persons,{ID,FirstName, LastName}, NAMED('Names'));
OUTPUT(Accounts,{reportdate, highcredit,balance}, NAMED('Campos_Accounts'));
OUTPUT(Persons,{ID, StreetAddress, City, State,ZipCode}, NAMED('Address_Info'));
OUTPUT(Accounts,{AccountNumber, LastActivityDate, Balance}, NAMED('Acct_Activity'));

*/

//Aula 4 - Treinando transformação de dados

/*
Myrec := RECORD 
  STRING15 Firstname := STD.Str.ToUpperCase(Persons.Firstname);
  STRING25 Lastname := STD.Str.ToUpperCase(Persons.Lastname);
	UNSIGNED3 Zipcode := (UNSIGNED3) Persons.Zipcode;
END;


MyTable := SORT(TABLE(Persons,MyRec),Lastname);
OUTPUT(MyTAble);

//MyTable := SORT(TABLE(Persons,{Firstname, Lastname, Zipcode}),Lastname);
//OUTPUT(MyTable);

MyRec2 := RECORD
 UNSIGNED recid;
 STRING15 Firstname;
 STRING25 Lastname;
 UNSIGNED3 Zipcode;
END;

MyRec2 MyTransf(Persons Le, UNSIGNED cnt) := TRANSFORM
 SELF.recid := cnt;
 SELF.Firstname := STD.Str.ToUpperCase(Le.Firstname);
 SELF.Lastname := STD.Str.ToUpperCase(Le.Lastname);
 SELF.Zipcode := (UNSIGNED3)Le.Zipcode;
END;

MyProj := PROJECT(Persons,MyTransf(LEFT,COUNTER));
OUTPUT(MyProj);
*/



//SIZEOF($.STD_Persons.Layout);
//$.STD_Persons.File;
//$.STD_Accounts.File;

//Aula 5 
 