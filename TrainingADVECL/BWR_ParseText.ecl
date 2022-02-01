//BWR_ParseText
d := DATASET('~CLASS::XX::IN::imdb_movies',{STRING line},CSV(SEPARATOR(''),QUOTE('')));
PATTERN arb       := ANY+;
PATTERN alpha     := PATTERN('[a-zA-Z]')+;
PATTERN Numbers   := PATTERN('[-0-9?,]')+;
PATTERN fs        := PATTERN('\t')+; //field separator
PATTERN Year      := '(' Numbers OPT('/' arb) ')';
PATTERN Vidtype   := ' (' alpha ')';
PATTERN Title     := arb Year OPT(Vidtype);
PATTERN movieyr   := Numbers;
PATTERN comment   := '(' arb ')';
PATTERN moviedata := Title fs movieyr OPT(fs comment);
