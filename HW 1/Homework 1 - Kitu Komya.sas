/*	Name: Kitu Komya
	UID: 404-491-375
	Section: Dis 1A
	Assignment: Homework 1
	Date Due: 1/23/2017
*/

data voa;
	infile '/folders/myfolders/sasuser.v94/voa.txt';
	input	#1 Address & $36.
			#2 City $ 1-15 State $ 16-17 Zip 19-24
			#3 Latitude Longitude;
run;
	
proc print data = voa;
	title 'List of Volunteers of America';
run;

data voa1;
	set voa;
	length Region $10;
	if (Longitude < -110) then Region = 'West';
	if (Latitude > 40) & (Longitude >= -110) & (Longitude <= -90) then Region = 'Mid-West';
	if (Latitude > 40) & (Longitude > -90) then Region = 'North-East';
	if (Latitude < 40) & (Longitude > -110) then Region = 'South';
run;

proc print data = voa1;
	title 'List of VOA with Regions';
run;	

data california;
	set voa;
	if (State = 'CA');
	/*drop State;	this is the alternate way to remove a variable. I have removed it in the proc step*/
run;

proc print data = california(drop = State);
	title 'VOA in California';
run;