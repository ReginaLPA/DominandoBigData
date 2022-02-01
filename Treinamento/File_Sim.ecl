EXPORT File_Sim := MODULE

   EXPORT Layout := RECORD
   STRING CONTADOR;
   STRING TIPOBITO;
   STRING DTOBITO;
   STRING HORAOBITO;
   STRING NATURAL;
   STRING DTNASC;
   STRING IDADE;
   STRING SEXO;
   STRING RACACOR;
   STRING ESTCIV;
   STRING ESC;
   STRING OCUP;
   STRING CODMUNRES;
   STRING CODBAIRES;
   STRING LOCOCOR;
   STRING CODESTAB;
   STRING CODMUNOCOR;
   STRING CODBAIOCOR;
   STRING IDADEMAE;
   STRING ESCMAE;
   STRING OCUPMAE;
   STRING QTDFILVIVO;
   STRING QTDFILMORT;
   STRING GRAVIDEZ;
   STRING GESTACAO;
   STRING PARTO;
   STRING OBITOPARTO;
   STRING PESO;
   STRING OBITOGRAV;
   STRING OBITOPUERP;
   STRING ASSISTMED;
   STRING EXAME;
   STRING CIRURGIA;
   STRING NECROPSIA;
   STRING LINHAA;
   STRING LINHAB;
   STRING LINHAC;
   STRING LINHAD;
   STRING LINHAII;
   STRING CAUSABAS;
   STRING DTATESTADO;
   STRING CIRCOBITO;
   STRING ACIDTRAB;
   STRING FONTE;
   STRING TPPOS;
   STRING DTINVESTIG;
   STRING CAUSABAS_O;
   STRING DTCADASTRO;
   STRING ATESTANTE;
   STRING FONTEINV;
   STRING DTRECEBIM;
   STRING UFINFORM;
   STRING CB_PRE;
   STRING MORTEPARTO;
   STRING TPOBITOCOR;
   END;

   EXPORT File:=DATASET('~class::rlp::superfile',Layout,CSV(HEADING(1)));	

END;