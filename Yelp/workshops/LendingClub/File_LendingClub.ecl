EXPORT File_LendingClub := MODULE

	EXPORT Layout:= RECORD
    STRING loan_amnt;
    STRING term;
    STRING int_rate;
    STRING installment;
    STRING grade;
    STRING sub_grade;
    STRING emp_title;
    STRING emp_length;
    STRING home_ownership;
    STRING annual_inc;
    STRING verification_status;
    STRING issue_d;
    STRING loan_status;
    STRING purpose;
    STRING title;
    STRING dti;
    STRING earliest_cr_line;
    STRING open_acc;
    STRING pub_rec;
    STRING revol_bal;
    STRING revol_util;
    STRING total_acc;
    STRING initial_list_status;
    STRING application_type;
    STRING mort_acc;
    STRING pub_rec_bankruptcies;
    STRING address;
	END;

	EXPORT File:=DATASET('~class::rlp::lending_club.csv',Layout,CSV(HEADING(1)));
	

END;