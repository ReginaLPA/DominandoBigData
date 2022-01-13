//Atentar o numero de registros po entidade
LayoutVeh := RECORD
    unsigned8 person_id;
    string2 orig_State;
    unsigned2 Year_Make;
    string5  Make_Code;
    string3   Vehliche_Type;
    string5  Body_code;
    string1   Vehliche_Use;
END;


LaoutPeople := RECORD
    unsigned8 id;
    string15 FirtName;
    string25  MiddleName;
    string2   NameSuffix;
    string8  FileDate;
    string1   Gender;
    string8   BirthDate;
    DATASET(LayoutVeh) Vehiclerecs;
END;

File_People := DATASET('~class::PeopleVeh',LayoutPeople,Thor);