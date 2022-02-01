EXPORT File_BusinessRaw := MODULE

EXPORT Layout := RECORD
 STRING business_id;
 STRING name;
 STRING address;
 STRING city;
 STRING state;
 STRING postal_code;
 STRING latitude;
 STRING longitude;
 STRING starts;
 STRING review_count;
 STRING attributes {XPATH('attributes/<>')};
 STRING categories;
 STRING hours {XPATH('hours/<>')};
 // DATASET (lBusinessAttribute) attributes;
 // DATASET (lBusinessCategory) categories;
 // DATASET (lBusinessHours) hours;
 
END;

 SHARED Filename := '~yelp::rla::business';
 EXPORT File := DATASET(Filename,Layout, JSON('/',NOROOT));
END;

