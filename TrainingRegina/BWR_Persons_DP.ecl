IMPORT $,STD;

Persons := $.File_Persons.File;
profileResults := STD.DataPatterns.Profile(Persons);
bestrecord := STD.DataPatterns.BestRecordStructure(Persons);

OUTPUT(profileResults, ALL, NAMED('profileResults'));
OUTPUT(bestrecord, ALL, NAMED('BestRecord'));