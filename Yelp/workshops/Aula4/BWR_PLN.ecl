//EXPORT BWR_PLN := 'todo';
#WORKUNIT('name','BWR_PLN');
/*
datafile := DATASET([{'And when Shechem the son of Hamor the Hivite, prince of Reuel'},
										{'the son of Bashemath the wife of Esau.'}], {STRING10000 line});

PATTERN ws1             := [' ','\t',','];
PATTERN ws              := ws1 ws1?;
PATTERN article         := ['A','The','Thou','a','the','thou'];
TOKEN Name              := PATTERN('[A-Z][a-zA-Z]+');
RULE Namet              := name OPT(ws ['the','king of','prince of'] ws name);
PATTERN produced        := OPT(article ws) ['begat','father of','mother of'];
PATTERN produced_by     := OPT(article ws) ['son of','daughter of'];
PATTERN produces_with   := OPT(article ws) ['wife of'];
RULE relationtype       := ( produced | produced_by | produces_with );
RULE progeny            := namet ws relationtype ws namet;
results                 := {STRING60 Le := MATCHTEXT(Namet[1]);
STRING60 Ri             := MATCHTEXT(Namet[2]);
STRING30 RelationPhrase := MATCHTEXT(relationtype) };

outfile1 := PARSE(datafile,line,progeny,results,SCAN ALL);
outfile1;
*/

rec := {STRING10000 line};
datafile := DATASET([{'Ge 34:2 And when Shechem the son of Hamor the Hivite, prince of the country, saw her,'+
										' he took her, and lay with her, and defiled her.'},
										{'Ge 36:10 These are the names of Esaus sons; Eliphaz the son of Adah the wife of Esau,'+
										' Reuel the son of Bashemath the wife of Esau.'}],rec);
										
PATTERN ws1 := [' ','\t',','];
PATTERN ws := ws1 ws1?;
PATTERN patStart := FIRST | ws;
PATTERN patEnd := LAST | ws;
PATTERN article := ['A','The','Thou','a','the','thou'];
TOKEN patWord := PATTERN('[a-zA-Z]+');
TOKEN Name := PATTERN('[A-Z][a-zA-Z]+');
RULE Namet := name OPT(ws ['the','king of','prince of'] ws name);
PATTERN produced := OPT(article ws) ['begat','father of','mother of'];
PATTERN produced_by := OPT(article ws) ['son of','daughter of'];
PATTERN produces_with := OPT(article ws) ['wife of'];
RULE relationtype := ( produced | produced_by | produces_with);
RULE progeny := namet ws relationtype ws namet;
results := RECORD
STRING60 Le := MATCHTEXT(Namet[1]);
STRING60 Ri := MATCHTEXT(Namet[2]);
STRING30 RelationPhrase := MatchText(relationtype);
END;

outfile1 := PARSE(datafile,line,progeny,results,SCAN ALL);
outfile1