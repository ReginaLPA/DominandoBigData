// EXPORT BWR_Output := 'todo';
//EXPORT FM_GenerateIOteration := FUNCTIONMACRO;
//EXPORT FM_GenerateIOteration := MACRO;

//Utilizando um INTERGER com parametro
// Num25 := 25;
// AddFive(INTEGER x=10) := x+5;  //passar um valor default
// NumResult0 := AddFive(Num25);
// NumResult1 := AddFive(); //30
// NumResult2 := AddFive(2); // 7
// NumResult3 := AddFive(10); //15
// NumResult4 := AddFive('A'); // Error:    Parameter x type mismatch - expected Integer, given String (10, 23), 2064, 
// OUTPUT(NumResult0);
// OUTPUT(NumResult1);
// OUTPUT(NumResult2);
// OUTPUT(NumResult3);




//Utilizando um DATASET como parametro 
// MyREc := {STRING1 Letter};
// SomeFile := DATASET([{'A'},{'B'},{'C'},{'D'},{'E'}],MyRec);


// FilteredDS(DATASET(MyRec)ds) := ds(Letter NOT IN ['A','C','E']);
// OUTPUT(FilteredDS(SomeFile));


//**Exemplo de sintaxe de FUNCTIONMACRO
/*
Caracteisticas da FUNCTIONMACRO
Tem return -  unico retorno da fun??o
Encapsulamento
Pode ser usada em contexto de express?o
*/
// FM_AddCat(DefinitionName,FirstArg,SecondArg) := FUNCTIONMACRO
	// DefinitionName := FirstArg + SecondArg ;
	// RETURN OUTPUT( DefinitionName);
// ENDMACRO;
// FM_AddCat(AddValues,5,10);  //passar os dados de acordo com o que desejar fazer inteiros para somar e string
// FM_AddCat(CatValues,'a','b');
//**contexto de express?o
// a:= FM_AddCat(AddValues,5,10); 
// a;

 // MyREc := {STRING1 Value1,STRING1 Value2};
 // SomeFile := DATASET([{'C','G'},{'C','C'}],MyRec);
 // OtherFile := DATASET([{'A','X'},{'B','CG'},{'A','B'}],MyRec);
 // FM_AddCat(JoinFiles,SomeFile,OtherFile);


//Estrutura Macro - n?o fica restrito ao unico retorno da fun??o
// FM_AddCat(DefinitionName,FirstArg,SecondArg) := MACRO
	// DefinitionName := FirstArg + SecondArg ;
	// OUTPUT( DefinitionName);
// ENDMACRO;
// FM_AddCat(AddValues,5,10);  //passar os dados de acordo com o que desejar fazer inteiros para somar e string
// FM_AddCat(CatValues,'a','b');

/*A MACRO n?o tem encapsulamento - 
FM_AddCat(AddValues,'a','b'); // 
a := FM_AddCat(AddValues,5,10); a:=OtValue := 5 +10; OUTPUT(OUtValue); //sintaxe n?o ? valida
a; n?o pode usar no texto de express?o*/



MAC_AddCat(FirstArg,SecondArg) := MACRO
  #UNIQUENAME(DefinitionName);
  %DefinitionName% := FirstArg + SecondArg ;
	OUTPUT(%DefinitionName%);
	OUTPUT('Hello ECLers');
ENDMACRO;

MAC_AddCat(5,10);  //passar os dados de acordo com o que desejar fazer inteiros para somar e string
MAC_AddCat('a','b');
