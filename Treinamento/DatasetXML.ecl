
/*<Dataset>
    <area>
    <code>201</code>
    <description>PA PennyIvania</description>
    <zone>Eastem Time Zone </zone>
    </area>
</Dataset>
*/
r := RECORD
    integer2 code;
    string110 description;
    string42 zone;
END;

d := DATASET('~class::rla::teste.xml',r,XML('Dataset/area'));
sort(d,code);
OUTPUT(d);