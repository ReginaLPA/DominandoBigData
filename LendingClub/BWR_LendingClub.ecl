//EXPORT BWR_LendingClub := 'todo';
IMPORT $, STD;
#WORKUNIT('name','Global (LendingClub)');

emprestimo:= $.File_LendingClub.File;


OUTPUT(emprestimo, NAMED('LendingClub'));



