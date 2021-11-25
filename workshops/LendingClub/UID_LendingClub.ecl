//EXPORT UID_LendingClub := 'todo';
IMPORT $,STD;

emprestimo:= $.File_LendingClub.File;
// New layout for formatted id
new_Layout := RECORD
		UNSIGNED row_id;		
		emprestimo;	
END;
// TRANSFORM structure and associated PROJECT function for cleansing the original dataset
New_Layout Reformatter(emprestimo L):=TRANSFORM
		SELF.row_id:=RANDOM();		
		SELF:=L;
END;
EXPORT UID_LendingClub := PROJECT(emprestimo,Reformatter(LEFT))
: PERSIST('~CLASS::rlp::PERSIST::UID_LendingClub');




