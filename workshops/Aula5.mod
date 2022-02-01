//Import:ecl:Workshops.Aula5.BWR_ViewPrepData
IMPORT $;
//Browse raw input data
OUTPUT($.File_Property.File,NAMED('Property'));
COUNT($.File_Property.File);
//Browse clean input data - notice the amount of data that had quality issues
// OUTPUT($.Prep01.myDataE,NAMED('CleanProperty'));
// OUTPUT($.Prep01_MI.myDataE,NAMED('CleanPropertyMI'));
// COUNT($.Prep01.myDataE);
//Browse clean train data and test data
// OUTPUT($.Prep01.myTrainData,NAMED('TrainData'));
// OUTPUT($.Prep01_MI.myTrainData,NAMED('TrainDataMI'));
// COUNT($.Prep01.myTrainData);
// OUTPUT($.Prep01.myTestData,NAMED('TestData'));
// COUNT($.Prep01.myTestData);
//Browse converted train and test data
// OUTPUT($.Convert02.myIndTrainDataNF,NAMED('IndTrain'));
// OUTPUT($.Convert02.myDepTrainDataNF,NAMED('DepTrain'));
// OUTPUT($.Convert02.myIndTestDataNF,NAMED('IndTest'));
// OUTPUT($.Convert02.myDepTestDataNF,NAMED('DepTest'));

// Teste da Função
// $.FN_GetPrice(95451,118720,2011,14774,1437,3,2,1,1968); //~130k

//Import:ecl:Workshops.Aula5.Convert02
IMPORT $;
IMPORT ML_Core;
myTrainData := $.Prep01.myTrainData;
myTestData  := $.Prep01.myTestData;
//Numeric Field Matrix conversion
ML_Core.ToField(myTrainData, myTrainDataNF);
ML_Core.ToField(myTestData, myTestDataNF);
// OUTPUT(myTrainDataNF, NAMED('TrainDataNF'));  //Uncomment to spot the Numeric Field Matrix conversion
// OUTPUT(myTestDataNF, NAMED('TestDataNF'));  //Uncomment to spot the Numeric Field Matrix conversion
//* <-- Delete the first forward slash (/) just before the asterisk (*) to comment out the entire MODULE
EXPORT Convert02 := MODULE
  //We have 9 independent fields and the last field (10) is the dependent
  EXPORT myIndTrainDataNF := myTrainDataNF(number < 10); // Number is the field number
  EXPORT myDepTrainDataNF := PROJECT(myTrainDataNF(number = 10), 
                                     TRANSFORM(RECORDOF(LEFT), 
                                              SELF.number := 1,
                                              SELF := LEFT));
  EXPORT myIndTestDataNF := myTestDataNF(number < 10); // Number is the field number
  EXPORT myDepTestDataNF := PROJECT(myTestDataNF(number = 10), 
                                    TRANSFORM(RECORDOF(LEFT), 
                                              SELF.number := 1,
                                              SELF := LEFT));
END;
// */

//Import:ecl:Workshops.Aula5.Convert02_MI
IMPORT $;
IMPORT ML_Core;
myTrainData := $.Prep01_MI.myTrainData;
myTestData  := $.Prep01_MI.myTestData;
//Numeric Field Matrix conversion
ML_Core.ToField(myTrainData, myTrainDataNF,wiField := wi_id);
ML_Core.ToField(myTestData, myTestDataNF,wiField := wi_id);
// OUTPUT(myTrainDataNF, NAMED('TrainDataNF'));  //Uncomment to spot the Numeric Field Matrix conversion
// OUTPUT(myTestDataNF, NAMED('TestDataNF'));  //Uncomment to spot the Numeric Field Matrix conversion
//* <-- Delete the first forward slash (/) just before the asterisk (*) to comment out the entire MODULE
EXPORT Convert02_MI := MODULE
  //We have 9 independent fields and the last field (10) is the dependent
  EXPORT myIndTrainDataNF := myTrainDataNF(number < 10); // Number is the field number
  EXPORT myDepTrainDataNF := PROJECT(myTrainDataNF(number = 10), 
                                     TRANSFORM(RECORDOF(LEFT), 
                                               SELF.number := 1,
                                               SELF := LEFT));
  EXPORT myIndTestDataNF := myTestDataNF(number < 10); // Number is the field number
  EXPORT myDepTestDataNF := PROJECT(myTestDataNF(number = 10), 
                                    TRANSFORM(RECORDOF(LEFT), 
                                              SELF.number := 1,
                                              SELF := LEFT));
END;
// */

//Import:ecl:Workshops.Aula5.File_Property
// The dataset we are using contains ficticious information from properties. 
// The regression goal is to train a model that can predict property prices.
// The raw dataset can be downloaded from our online ECL Training Advanced ECL (part1) class:
// https://learn.lexisnexis.com/Activity/1102# (OnlineProperty)
EXPORT File_Property := MODULE
  EXPORT Layout := RECORD
   UNSIGNED8 personid;
   INTEGER8  propertyid;
   STRING10  house_number;
   STRING10  house_number_suffix;
   STRING2   predir;
   STRING30  street;
   STRING5   streettype;
   STRING2   postdir;
   STRING6   apt;
   STRING40  city;
   STRING2   state;
   STRING5   zip;
   UNSIGNED4 total_value;
   UNSIGNED4 assessed_value;
   UNSIGNED2 year_acquired;
   UNSIGNED4 land_square_footage;
   UNSIGNED4 living_square_feet;
   UNSIGNED2 bedrooms;
   UNSIGNED2 full_baths;
   UNSIGNED2 half_baths;
   UNSIGNED2 year_built;
  END;
  EXPORT File := DATASET('~Tutorial::BoostForest::Property',Layout,THOR);
 
 //New record structure for training the property price model  
	EXPORT MLProp := RECORD
   UNSIGNED8 PropertyID; //identifier - required for LearningTrees NF
   UNSIGNED3 zip;				 //Categorical independent variable - need to be converted to a numerical value
   UNSIGNED4 assessed_value;
   UNSIGNED2 year_acquired;
   UNSIGNED4 land_square_footage;
   UNSIGNED4 living_square_feet;
   UNSIGNED2 bedrooms;
   UNSIGNED2 full_baths;
   UNSIGNED2 half_baths;
   UNSIGNED2 year_built;
   UNSIGNED4 total_value; //Dependent Variable - what we are trying to predict
 END;
 
 //New record structure for training multiple property price models using Myriad Interface
 EXPORT MLPropMI := RECORD
  MLProp;
  UNSIGNED4 wi_id;   //work-item id for Myriad Interface
END;
END;

//Import:ecl:Workshops.Aula5.FN_GetPrice
IMPORT $;
IMPORT ML_Core;
IMPORT LearningTrees AS LT;

// Função de predição de preços de imóveis
EXPORT FN_GetPrice(Zip, Assess_val, Year_acq, 
						Land_sq_ft, Living_sq_ft, Bedrooms, 
						Full_baths, Half_baths, Year_built) := FUNCTION

		// Transformação dos parâmetros de entrada no formato de ML data frame				
		myInSet := [zip, assess_val, year_acq, land_sq_ft, living_sq_ft, 
								bedrooms, full_baths, half_baths, year_built];
		myInDs := DATASET(myInSet, {REAL8 myInValue});
		ML_Core.Types.NumericField PrepData(RECORDOF(myInDS) Le, INTEGER C) := TRANSFORM
				SELF.wi 		:= 1,
				SELF.id		 	:= 1,
				SELF.number := C,
				SELF.value 	:= Le.myInValue;
		END;
		myIndepData := PROJECT(myInDs, PrepData(LEFT,COUNTER));
		
		// Predição e retorno do valor do imóvel consultado
		mymodel := DATASET('~mymodelXXX',ML_Core.Types.Layout_Model2,FLAT,PRELOAD); //Substitua XXX pelas iniciais do seu nome completo
		myLearner := LT.BoostedRegForest(10,,10,,,[1]);
		myPredictDeps := MyLearner.Predict(myModel, myIndepData);
	
		RETURN OUTPUT(myPredictDeps,{preco:=ROUND(value)});
		
END;

//Import:ecl:Workshops.Aula5.Prep01
IMPORT $;
Property := $.File_Property.File;
ML_Prop  := $.File_Property.MLProp;
EXPORT Prep01 := MODULE
  MLPropExt := RECORD(ML_Prop)
   UNSIGNED4 rnd; // A random number
  END;
 // Clean the data and assign a random number to each record
  CleanFilter := Property.zip <> '' AND Property.assessed_value <> 0 AND Property.year_acquired <> 0 AND 
                 Property.land_square_footage <> 0 AND Property.living_square_feet <> 0 AND 
							   Property.bedrooms <> 0 AND Property.year_Built <> 0;
  EXPORT myDataE := PROJECT(Property(CleanFilter), TRANSFORM(MLPropExt, 
                                                             SELF.rnd := RANDOM(),
                                                             SELF.Zip := (UNSIGNED3)LEFT.Zip,
                                                             SELF := LEFT));
																							               
  // Shuffle your data by sorting on the random field
  SHARED myDataES := SORT(myDataE, rnd);
  // Now cut the deck and you have random samples within each set
  // While you're at it, project back to your original format -- we dont need the rnd field anymore
  // Treat first 5000 as training data.  Transform back to the original format.
  EXPORT myTrainData := PROJECT(myDataES[1..5000], ML_Prop);
                                  
  // Treat next 2000 as test data
  EXPORT myTestData  := PROJECT(myDataES[5001..7000], ML_Prop);
                                 
END;

//Import:ecl:Workshops.Aula5.Prep01_MI
IMPORT $;
Property := $.File_Property.File;
ML_Prop  := $.File_Property.MLPropMI;
EXPORT Prep01_MI := MODULE
  MLPropExt := RECORD(ML_Prop)
    UNSIGNED4 rnd; // A random number
  END;
  // Clean the data, assign a random number to each record and 
  CleanFilter := Property.zip <> '' AND Property.assessed_value <> 0 AND Property.year_acquired <> 0 AND 
                 Property.land_square_footage <> 0 AND Property.living_square_feet <> 0 AND 
							   Property.bedrooms <> 0 AND Property.year_Built <> 0;
  EXPORT myDataE := PROJECT(Property(CleanFilter), TRANSFORM(MLPropExt, 
                                                             SELF.rnd := RANDOM(),
                                                             SELF.Zip := (UNSIGNED3)LEFT.Zip,
			  																										 SELF.wi_id := MAP(LEFT.State = 'CA' => 1,
				  																									                   LEFT.State = 'NY' => 2,
					  																																	 LEFT.State = 'FL' => 3,
						  																																 0),
                                                             SELF := LEFT));
								  															             
  // Shuffle your data by sorting on the random field
  SHARED myDataES := SORT(myDataE(wi_id <> 0), rnd);
  // Now cut the deck and you have random samples within each set
  // While you're at it, project back to your original format -- we dont need the rnd field anymore
  // Treat first 5000 as training data.  Transform back to the original format.
  EXPORT myTrainData := PROJECT(myDataES[1..5000], ML_Prop);
                                 
  // Treat next 2000 as test data
  EXPORT myTestData  := PROJECT(myDataES[5001..7000], ML_Prop);
                               
END;

//Import:ecl:Workshops.Aula5.Train03
IMPORT LearningTrees AS LT;
IMPORT ML_Core;
IMPORT $;
//Training and Test data
XTrain := $.Convert02.myIndTrainDataNF;
YTrain := $.Convert02.myDepTrainDataNF;
XTest  := $.Convert02.myIndTestDataNF;
YTest  := $.Convert02.myDepTestDataNF;
//Train Boosted Forest model on Property data
myLearner    := LT.BoostedRegForest(10,,10,,,[1]); // Make the zipcode field a nominal (categorical) field.
myModel      := myLearner.GetModel(XTrain,YTrain);
OUTPUT(myModel,,'~mymodelXXX',NAMED('TrainedModel'),OVERWRITE); //Replace XXX by your initials
//Test Boosted Forest model on Property data
MyPredict := myLearner.Predict(myModel,XTest);
OUTPUT(MyPredict, NAMED('PredictedValues'));//workitem,uniqueid,field number, dependent value
//Assess Boosted Forest model on Property data
assessmentR2   := ML_Core.Analysis.Regression.Accuracy(MyPredict,YTest);
OUTPUT(assessmentR2, NAMED('Accuracy'));

//Import:ecl:Workshops.Aula5.Train03_MI
IMPORT LearningTrees AS LT;
IMPORT ML_Core;
IMPORT $;
//Training and Test data
XTrain := $.Convert02_MI.myIndTrainDataNF;
YTrain := $.Convert02_MI.myDepTrainDataNF;
XTest  := $.Convert02_MI.myIndTestDataNF;
YTest  := $.Convert02_MI.myDepTestDataNF;
//Train Boosted Forest model on Property data
myLearner    := LT.BoostedRegForest(,,,,,[1]); // Make the zipcode field a nominal (categorical) field.
myModel      := myLearner.GetModel(XTrain,YTrain);
//Test Boosted Forest model on Property data
MyPredict := myLearner.Predict(myModel,XTest);
OUTPUT(MyPredict, NAMED('PredictedValues'));//workitem,uniqueid,field number, dependent value
//Assess Boosted Forest model on Property data
assessmentR2   := ML_Core.Analysis.Regression.Accuracy(MyPredict,YTest);
OUTPUT(assessmentR2, NAMED('Accuracy'));


