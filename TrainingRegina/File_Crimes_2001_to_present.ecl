EXPORT File_Crimes_2001_to_present := MODULE

	EXPORT Layout:=RECORD		
		UNSIGNED8 ID;
    STRING8	  Case_Number;	
    STRING22	Date;
		STRING30  Block;	
		UNSIGNED4 IUCR; 	
		STRING30  Primary_Type; 	
		STRING35  Description; 	
		STRING40  Location_Description; 	
		STRING5		Arrest; 	
		STRING5 	Domestic; 	
		UNSIGNED4	Beat; 	
		UNSIGNED3	District; 	
		UNSIGNED4	Ward; 	
		UNSIGNED2 CommunityArea; 	
		STRING3	FBI_Code; 	
		UNSIGNED8 X_Coordinate; 	
		UNSIGNED8	Y_Coordinate; 	
		INTEGER4	Year; 	
		STRING22	Updated_On; 	
		UNSIGNED2	Latitude; 	
		UNSIGNED2	Longitude; 	
		STRING29	Location;

		
	END;

	EXPORT File:=DATASET('~CLASS::rlp::INTRO::Crimes_-_2001_to_present.csv',Layout,CSV(HEADING(1)));
	

END;

