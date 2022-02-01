//EXPORT Exec_sintaxe_module := 'todo';

//for this previously defined INTERFACE:
// EXPORT
iHeaderFileSearch := INTERFACE
// EXPORT STRING2 state_val;
// EXPORT STRING25 city_val :=";
// END;
******************************************************
IMPORT $;
//define a concrete instance:
SearchParms := MODULE iHeaderFileSearch
 EXPORT STRING2 state_val := 'FL'; //only pass needed parameters
END;

//define a function that uses that interface
Fetch_Address iHeaderFileSearch opts) := FUNCTION
	//define passed value filters
	IsStCityFilter := File_People.State = opts.state_val;
	RETURN $.File_People(IsStCityFilter);
END;

//and use it to call the function that takes that interface as a parameter
OUTPUT(Fetch_Address(SearchParms));