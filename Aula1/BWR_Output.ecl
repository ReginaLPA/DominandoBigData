// EXPORT BWR_Output := 'todo';
//mydef := 'ola';
//OUTPUT(mydef);
#WORKUNIT('name','Global (non-local processing)');
meulayout := RECORD
	STRING Firstname;
	STRING Lastname;
	UNSIGNED1 Age;
	STRING1 Gender;

END;


meudataset := DATASET([{'Alysson','Oliveira',26,'M'},
                       {'Bruno','Camargo',22,'M'},
											 {'Elaine','Silva',19,'F'},
											 {'Julia','Caetano',45,'F'},
											 {'Orlando','Silva',67,'M'}],meulayout);
											 
OUTPUT(meudataset);



meudsfiltrado := meudataset(Firstname[1]='A' AND Age < 65);

OUTPUT(meudsfiltrado);

// COUNT(meudsfiltrado);

minhatabela := TABLE(meudataset,{Firstname,LastName});

// OUTPUT(minhatabela);

minhatabelaordenada := SORT(minhatabela,Lastname);
OUTPUT(minhatabelaordenada);

meulayout2 := RECORD
  UNSIGNED recid;
  STRING Firstname;
	STRING Lastname;
	UNSIGNED1 Age;
	STRING1 Gender;
END;


meulayout2 MeuTransf(meulayout Le) := TRANSFORM
  SELF.recid:=RANDOM();
  SELF := Le;
END;

meuproject := PROJECT(meudataset,MeuTransf(LEFT));

OUTPUT(meuproject, ALL, NAMED('MeuTransf'));


/*
// *****
// Elementos constituintes basicos da ECL
// Uma definicao
// Mydef := 'Olá mundo';  // definicao do tipo "value"

// Uma acao
// OUTPUT('Olá mundo');
// OUTPUT(mydef);

// *****
// Estruturas de dados basicas em ECL
// Estrutura RECORD
rec := RECORD
  STRING10  Firstname;
	STRING    Lastname;
	STRING1   Gender;
	UNSIGNED1 Age;
	INTEGER   Balance;
	DECIMAL7_2 Income;
END;

// Declaracao DATASET
ds := DATASET([{'Alysson','Oliveira','M',26,100,1000.50},
               {'Bruno','Camargo','',22,-100,500.00},
							 {'Elaine','Silva','F',19,-50,750.60},
							 {'Julia','Caetano','F',45,500,5000},
							 {'Orlando','Silva','U',67,300,4000}],rec);
// OUTPUT(ds);

// *****
// Filtragem de datasets
// recset := ds(Age<65);
// recset; //Equivale a: OUTPUT(recset);

// recset := ds(Age<65,Gender='M');
// recset;

// IsSeniorMale := ds.Age>65 AND ds.Gender='M'; //definição do tipo "boolean"
// recset := ds(IsSeniorMale);
// recset;

// SetGender := ['M','F'];  //definicao do tipo "set"
// recset := ds(Gender IN SetGender);
// recset;						// definição do tipo "recordset"
// COUNT(recset);    //Equivale a: OUTPUT(COUNT(recset));

// *****
// Transformacoes basicas em ECL
// Eliminacao de campos desnecessarios
// tbl := TABLE(ds,{Firstname,LastName,Income});
// tbl;

// Ordenacao de valores
// sortbl := SORT(tbl,LastName);
// sortbl;

// Remocao de duplicidades
// dedptbl := DEDUP(sortbl,LastName);
// dedptbl;

// Adicao de campo no dataset
rec2 := RECORD
  UNSIGNED   recid;  
	STRING10   Firstname;
	STRING     Lastname;
	STRING1    Gender;
	UNSIGNED1  Age;
	INTEGER    Balance;
	DECIMAL7_2 Income;
END;

rec2 MyTransf(rec Le, UNSIGNED cnt) := TRANSFORM
  SELF.recid:=cnt;
  SELF := Le;
END;

newds := PROJECT(ds,MyTransf(LEFT,COUNTER));

//newds;



*/

