//class::rlp::superfile
IMPORT $,STD,DataPatterns;
#WORKUNIT('name','BWR_Sim');

Sim := $.File_Sim.File;
//sim_opt:= $.File_Sim_optimized.File;


OUTPUT(Sim, NAMED('Sim'));

// Profiling the raw data
//OUTPUT(DataPatterns.Profile(Sim));