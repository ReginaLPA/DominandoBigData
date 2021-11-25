IMPORT $;
#WORKUNIT('name','Global (non-local processing)');
Persons := $.File_Persons.File;
Accounts := $.File_Accounts.File;

//Filtros
Persons(State='FL');
Persons(State='FL',City='MIAMI');
Persons(State='FL',City='MIAMI',ZipCode='33102');
Persons(FirstName >= 'B', FirstName > 'C');

Accounts(OpenDate[..4] >= '2000');
COUNT(Accounts(OpenDate[..4] >= '2000'));



Persons(State = 'FL');
COUNT(Persons(State = 'FL')); //40854

Persons(State = 'FL',City = 'MIAMI');
COUNT(Persons(State = 'FL',City = 'MIAMI')); //2438

Persons(State = 'FL',City = 'MIAMI',ZipCode='33102');
COUNT(Persons(State = 'FL',City = 'MIAMI',ZipCode='33102')); //40

Persons(FirstName >= 'B', FirstName < 'C');
COUNT(Persons(FirstName >= 'B', FirstName < 'C'));//31193

Persons(FileDate[..4] > '2000');
COUNT(Persons(FileDate[..4] > '2000'));//687

OUTPUT(COUNT(Persons), NAMED('Pessoas'));