EXPORT ValidInRange(PassedVal, loVal, HiVal):= Function
IsNegative := Loval < 0 OR Hival < 0;
IsBackward := Hival < LoVal;
IsInrange := PassedVal BETWEEN LoVal and HiVal;

RETURN MAP(IsNegative =>'Invalid input - Negative Value',
					IsBackward => 'Invalid input - Parameters are reversed',
					IsInrange => 'In Range','Out of Range');
END;
