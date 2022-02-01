//EXPORT File_Persons_otimized := 'todo';

oldName := '~class::rla::intro::chicago_crimes';
oldLayout := RECORDOF(oldName, LOOKUP);
oldDataset := DATASET(oldName, oldLayout, csv);

NewLayout := RECORD
    string8 id;
    string11 case_number;
    string22 date;
    string38 block;
    string4 iucr;
    string33 primary_type;
    string60 description;
    string53 location_description;
    string6 arrest;
    string8 domestic;
    string4 beat;
    string8 district;
    string4 ward;
    string14 community_area;
    string8 fbi_code;
    string12 x_coordinate;
    string12 y_coordinate;
    string4 year;
    string22 updated_on;
    string12 latitude;
    string13 longitude;
    string29 location;
END;

NewLayout MakeNewLayout(oldLayout L) := TRANSFORM
    SELF.id := (string8)L.id;
    SELF.case_number := (string11)L.case_number;
    SELF.date := (string22)L.date;
    SELF.block := (string38)L.block;
    SELF.iucr := (string4)L.iucr;
    SELF.primary_type := (string33)L.primary_type;
    SELF.description := (string60)L.description;
    SELF.location_description := (string53)L.location_description;
    SELF.arrest := (string6)L.arrest;
    SELF.domestic := (string8)L.domestic;
    SELF.beat := (string4)L.beat;
    SELF.district := (string8)L.district;
    SELF.ward := (string4)L.ward;
    SELF.community_area := (string14)L.community_area;
    SELF.fbi_code := (string8)L.fbi_code;
    SELF.x_coordinate := (string12)L.x_coordinate;
    SELF.y_coordinate := (string12)L.y_coordinate;
    SELF.year := (string4)L.year;
    SELF.updated_on := (string22)L.updated_on;
    SELF.latitude := (string12)L.latitude;
    SELF.longitude := (string13)L.longitude;
    SELF.location := (string29)L.location;
    SELF := L;
END;

newDataset := PROJECT(oldDataset, MakeNewLayout(LEFT));
OUTPUT(newDataset, , '~class::rla::intro::chicago_crimes::optimized');
