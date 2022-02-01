//EXPORT Limit := 'todo';

SomeFile1 := DATASET([{1,'A'},{2,'B'},{3,'C'},{4,'D'},{5,'E'}],
										{INTEGER1 number,STRING1 Letter1});

//Limita a quantidade de registros	
//C := LIMIT(SomeFile1,4); //Throws an exception
//C;

//Y := LIMIT(SomeFile1,4, FAIL(2020,'Too Many results!')); //Throws an exception
//Y := LIMIT(SomeFile1,4, SKIP); //Throws an exception, just no record
// Y := LIMIT(SomeFile1,4, ONFAIL(TRANSFORM({INTEGER1 number, STRING1 letter1},
							// SELF := ROW({0,''},{INTEGER1 number, STRING1 Letter1})))); //single record output
// Y;

SomeFile2 := DATASET([{1,'A'},{2,'B'},{2,'B'},{2,'Y'},
										{3,'C'},{3,'Z'},{4,'D'},{5,'E'}],
										{INTEGER1 number,STRING1 Letter2});
										
										
// YL := JOIN(SomeFile1,SomeFile2,
					// LEFT.number=RIGHT.number,
					// LIMIT(2,SKIP));
// YL;

YA := JOIN(SomeFile1,SomeFile2,
					LEFT.number=RIGHT.number,
					ATMOST(LEFT.number=RIGHT.number,2));
YA;