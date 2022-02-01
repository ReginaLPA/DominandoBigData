//EXPORT Ex_Rollup := 'todo';

//a crosstab table of last names and the number of times they occur
MyRec := RECORD
Person.per_last_name;
INTEGER4 PersonCount := 1;
END;
LnameTable := TABLE(Person,MyRec); //create dataset to work with
SortedTable := SORT(LnameTable,per_las_name); //sort it first
MyRec Xform(MyRec L,MyRec R) := TRANSFORM
SELF.PersonCount := L.PersonCount + 1;
SELF := L; //keeping the L rec makes it KEEP(1),LEFT
// SELF := R; //keeping the R rec would make it KEEP(1),RIGHT
END;
XtabOut := ROLLUP(SortedTable,
LEFT.per_last_name=RIGHT.per_last_name,
Xform(LEFT,RIGHT));