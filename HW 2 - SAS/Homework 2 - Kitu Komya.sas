/*	Name: Kitu Komya
	UID: 404-491-375
	Section: Dis 1A
	Assignment: Homework 2
	Date Due: 2/2/2017
*/


/*1*/
data voa;
	infile '/folders/myfolders/sasuser.v94/voa2.txt';
	input	#1 Address & $36.
			City $ 37-53 State $ Zip
			Revenue Grade $;
run;

proc print data = voa;
	title 'List of Volunteers of America';
run;


/*2-1*/
proc sort data = voa out = totalRev;
	by Grade;
run;

data total (drop = Address City State Zip);
	set totalRev;
	by Grade;
	if First.Grade then TotalRevenue=0;
	TotalRevenue + Revenue;
	if Last.Grade;
run;	
	
proc print data = total(drop = Revenue);
	title 'Total Revenue for each Grade level';
run;


/*2-2*/
proc sort data = voa out = maxRev;
	by Grade Revenue;
run;
data max (drop = Address State Zip);
	set maxRev;
	by Grade;
	if Last.Grade;
	HoldRevenue = Revenue;
	if Last.Grade;
	HoldCity = City;
run;
proc print data = max (drop = Revenue City);
	title 'Maximum Revenue and City';
run;


/*3-1*/
data location;
	infile '/folders/myfolders/sasuser.v94/location.txt';
	input Zip latitude longitude @@;

proc print data = location;
	title 'Locations of Volunteers of America';
run;

	
/*3-2*/
proc sort data = voa out = voaSort;
	by Zip;
run; 	
proc sort data = location out = locSort;
	by Zip;
run;
data combined;
	merge voaSort locSort;
	by Zip;
run;
proc print data = combined;
	title 'Full data for Volunteers of America';
run;


/*4*/
proc glm data = voa;
  class Grade;
  model Revenue = Grade / ss3;
  title 'ANOVA to test if mean is different among various grade types';
run;


	