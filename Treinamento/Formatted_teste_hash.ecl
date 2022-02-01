//EXPORT Formatted_teste_hash := 'todo';

Layout_Combined PopulateRecs(Layout_Combined L,
															 Layout_Combined R, INTEGER HashVal) := TRANSFORM
															 CSZ_Rec := (HashVal % CountCSZ) + 1;
															 SELF.PersonID := IF(L.PersonID = 0,
															 Thorlib.Node() + 1,
 L.PersonID + CLUSTERSIZE);
	 SELF.MiddleInitial := SetMiddleInitials[(HashVal % 100) + 1 ];
	 SELF.Gender := CHOOSE((HashVal % 2) + 1,'F','M');
	 SELF.Street := SetStreets[(HashVal % 2400) + 1 ];
	 SELF.City := SetCity[CSZ_Rec];
	 SELF.State := SetStates[CSZ_Rec];
	 SELF.Zip := SetZips[CSZ_Rec];
	 SELF := R;
END;
base_fln_dist := DISTRIBUTE(base_fln,HASH32(FirstName,LastName));

base_people := ITERATE(base_fln_dist,
		 PopulateRecs(LEFT, RIGHT,
		 HASHCRC(RIGHT.FirstName,RIGHT.LastName)),
		 LOCAL);
base_people_dist := DISTRIBUTE(base_people,HASH32(PersonID));
