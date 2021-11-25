

IMPORT $,std;

EXPORT STD_Accounts := MODULE
EXPORT Layout := RECORD
$.UID_Accounts.RecID;
$.UID_Accounts.PersonID;
UNSIGNED4 ReportDate := (UNSIGNED4)$.UID_Accounts.ReportDate;
$.UID_Accounts.IndustryCode;
$.UID_Accounts.Member;
UNSIGNED4 OpenDate := (UNSIGNED4)$.UID_Accounts.OpenDate;
$.UID_Accounts.TradeType;
$.UID_Accounts.TradeRate;
$.UID_Accounts.Narr1;
$.UID_Accounts.Narr2;
$.UID_Accounts.HighCredit;
$.UID_Accounts.Balance;
$.UID_Accounts.Terms;
$.UID_Accounts.TermTypeR;
$.UID_Accounts.AccountNumber;
UNSIGNED4 LastActivityDate := (UNSIGNED4)$.UID_Accounts.LastActivityDate;
$.UID_Accounts.Late30Day;
$.UID_Accounts.Late60Day;
$.UID_Accounts.Late90Day;
$.UID_Accounts.TermType;
END;
EXPORT File := TABLE($.UID_Accounts,Layout)
: PERSIST('~CLASS::rlp::PERSIST::STD_Accounts');
END;