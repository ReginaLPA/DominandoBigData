//EXPORT BWR_LendingClub := 'todo';
IMPORT $,STD,DataPatterns;
#WORKUNIT('name','BWR_LendingClub');

emprestimo:= $.File_LendingClub.File;
emprestimo_opt:= $.File_LendingClub_optimized.File;


//OUTPUT(emprestimo, NAMED('LendingClub'));
OUTPUT(emprestimo_opt, NAMED('LendingClub_optmized'));
COUNT(emprestimo_opt);

// Profiling the raw data
//OUTPUT(DataPatterns.Profile(emprestimo));
//OUTPUT(DataPatterns.Benford(emprestimo,'loan_amnt','total_pymnt'));


//Definir estrutura otimizada dos dados 
//DataPatterns.BestRecordStructure(emprestimo);
//DataPatterns.BestRecordStructure(emprestimo,,,TRUE)

//DataPatterns.Profile(emprestimo_opt)
//profileResults := STD.DataPatterns.Profile(emprestimo);
//bestrecord := STD.DataPatterns.BestRecordStructure(emprestimo);
//OUTPUT(profileResults, ALL, NAMED('profileResults'));
//OUTPUT(bestrecord, ALL, NAMED('BestRecord'));



