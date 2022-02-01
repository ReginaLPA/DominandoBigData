// EXPORT Exe_Interface := 'todo';

EXPORT iHeaderFileSearch := INTERFACE
	EXPORT STRING2 state_val ;    //no default value = NOT omittable
	EXPORT STRING25 city_val := ";
END;

EXPORT Fetch_Address (iHeaderFileSearch opts) := FUNCTION
	StatePassed := opts.state_val <>";
	CityPassed := opts.city_val <>";
	SFilter := HeaderFile.State = opts.state_val;
	CFilter := HeaderFile.City = opts.city_val;
	filter := MAP(StatePassed AND CityPassed => SFilter AND CFilter,
								StatePassed => SFilter,
								CityPassed => CFilter,
								FALSE);
RETURN HeaderFile(filter);
END;