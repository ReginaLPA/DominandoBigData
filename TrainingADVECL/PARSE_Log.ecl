//Declare the record to store each record from 
//the raw input file. Since the file has lines of log data,
//the record will need one string field to store each line.
RawLayout := RECORD
 STRING rawTxt;
END;
//Declare the file. In this example, 
//for simplicity, the content is shown inline
fileRaw := DATASET(
 [{'127.0.0.1 - frank [10/Oct/2000:13:55:36 -0700] "GET /apache_pb.gif HTTP/1.0" 200 2326'},
  {'This record is absolute garbage and does not match any patterns'}],
                    RawLayout);
PATTERN alphaFmt     := PATTERN('[a-zA-Z]')+;
PATTERN alphaNumbFmt := PATTERN('[a-zA-Z0-9]')+;
PATTERN sepFmt       := ' '+;
PATTERN numFmt       := PATTERN('[0-9]')+;
PATTERN ipFmt        := numFmt '.' numFmt '.' numFmt '.' numFmt; 
PATTERN identFmt     := '-';
PATTERN authuserFmt  := alphaNumbFmt;
PATTERN hoursFromGMT := PATTERN('[\\-\\+]') numFmt;
PATTERN yearFmt      := numFmt;
PATTERN monthFmt     := alphaNumbFmt;
PATTERN dayFmt       := numFmt;
PATTERN hoursFmt     := numFmt;
PATTERN minutesFmt   := numFmt;
PATTERN secondsFmt   := numFmt;
PATTERN dateFmt      := '[' dayFmt '/' monthFmt '/' yearFmt ':' hoursFmt ':' minutesFmt ':' secondsFmt ' ' hoursFromGMT ']';
PATTERN cmdFmt       := alphaFmt;
PATTERN notQuoteFmt  := PATTERN('[^"]')*;
PATTERN paramsFmt    := OPT('?' notQuoteFmt);
PATTERN urlFmt       := PATTERN('[^"\\?]')*;
PATTERN httpMethodFmt := 'HTTP/' numFmt '.' numFmt;
PATTERN requestFmt   := '"' cmdFmt urlFmt paramsFmt httpMethodFmt '"';
PATTERN statusFmt    := numFmt;
PATTERN bytesFmt     := numFmt;
PATTERN line         := ipFmt sepFmt identFmt sepFmt authUserFmt sepFmt dateFmt sepFmt
                        requestFmt sepFmt statusFmt sepFmt bytesFmt;
LogLayout := RECORD 
 STRING ip       := MATCHTEXT(ipFmt);
 STRING authUser := MATCHTEXT(authuserFmt);
 STRING date     := MATCHTEXT(dateFmt);
 STRING request  := MATCHTEXT(requestFmt);
 STRING status   := MATCHTEXT(statusFmt);
 STRING bytes    := MATCHTEXT(bytesFmt);
END;
										
logFile := PARSE(fileRaw,
                 rawTxt,
                 line,
                 LogLayout,FIRST);
OUTPUT(logFile);
//How to record error lines that do not match the specified pattern? 
//In other words malformed input.
ErrorLayout := RECORD
STRING t := fileRaw.rawTxt;
end;
e := parse(fileRaw,
           rawTxt,
           line,
           ErrorLayout,NOT MATCHED ONLY);
OUTPUT(e);
