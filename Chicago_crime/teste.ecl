//EXPORT teste := 'todo';

Import $,STD;
Crimes:= $.Formatted_File;

r:= RECORD
  $.Formatted_File.Primary_Type;
	//MySum := SUM(GROUP,Crimes.Primary_Type);
	//Integer soma_type:= (INTEGER)SUM(types);
	//Integer cnt:=(Integer)(COUNT(GROUP)*100/COUNT(GROUP)+'%');
	INTEGER cnt:=COUNT(GROUP);
	//Unsigned prcnt:= SUM(cnt);
		
	//INTEGER total:=AVE(Crimes,Crimes.Primary_Type);
	//INTEGER mysum:=AVE(crimes,cnt);
	 //REAL total := AVE(GROUP,(REAL)Crimes.Primary_Type);
END;
XTAB_CRIMES :=TABLE($.Formatted_File,r,primary_type);
XTAB_CRIMES