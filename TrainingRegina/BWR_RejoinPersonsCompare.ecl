IMPORT $;

//DATASETS of renormed tables created in Exercise 7B
RJPersons := DATASET('~CLASS::rlp::OUT::Persons_Rejoined',$.File_Persons.Layout,THOR);
//SORT the APPENDed records, and then DEDUP.
AppendRecs := $.File_Persons.File + RJPersons;
SortRecs := SORT(AppendRecs,WHOLE RECORD);
DedupPersons := DEDUP(SortRecs,WHOLE RECORD);
//Count of rejoined records created in Exercise 7B
OUTPUT(COUNT(RJPersons),NAMED('Input_Recs_Persons'));
//This result should be zero
OUTPUT(COUNT(DedupPersons)-count(RJPersons),NAMED('Dup_Persons'));