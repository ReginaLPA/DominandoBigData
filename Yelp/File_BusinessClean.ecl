IMPORT $,Std;

EXPORT File_BusinessClean :=  MODULE

EXPORT lBusinessCategory := RECORD
	STRING category_name
END;

EXPORT lBusinessAttribute := RECORD
	STRING attribute ;
	STRING value ;
END;

EXPORT lBusinessHoursTimes := RECORD
	UNSIGNED hour;
	UNSIGNED minute;
END;

EXPORT lBusinessHours := RECORD
	STRING day_name; 
  DATASET(lBusinessHoursTimes) open;
	DATASET(lBusinessHoursTimes ) close;
END;

	
END;

EXPORT lBusinessClean := RECORD
		STRING business_id;
		STRING name;
		STRING neighborhood;
		STRING address;
		STRING city;
		STRING state;
		STRING postal_code;
		REAL latitude;
		REAL longitude;
		UNSIGNED stars;
		UNSIGNED review_count;
		BOOLEAN is_open;
		DATASET (lBusinessAttribute) Attributes ;
		DATASET (lBusinessCategory) Categories;
		DATASET (lBusinessHours) Hours;
		STRING type ;
	END;
END;
	