//EXPORT XTAB_Persons_Gender := 'todo';


IMPORT $;

IMPORT STD;

r := RECORD
$.Formatted_File.year;
INTEGER cnt := COUNT(GROUP);
END;
EXPORT XTAB_Persons_Gender := TABLE($.Formatted_File,r,year);