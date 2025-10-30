************************************************************;
*	Deen Sonbol												;
*	Class Project 1												;
*	March 3, 2025											;
*	SAS 9.4													;
*															;
* 	reading raw data 						                                ;						
************************************************************;

libname demo xport "/home/u64141724/BIST25/P_DEMO.xpt"; 
libname bp xport "/home/u64141724/BIST25/P_BPXO.xpt"; 
libname bm xport "/home/u64141724/BIST25/P_BMX.xpt" ; 
libname dib xport "/home/u64141724/BIST25/P_DIQ.xpt"; 
libname chol xport "/home/u64141724/BIST25/P_TRIGLY.xpt"; 

proc contents data = demo.p_demo; 
run; 
proc contents data = bp.p_bpxo; 
run; 
proc contents data = bm.p_bmx ; 
run; 
proc contents data = dib.p_diq ; 
run; 
proc contents data = chol.p_trigly ; 
run; 

proc sort data = demo.p_demo out = demog; 
	by seqn; 
run; 
proc sort data = bp.p_bpxo out = bpx; 
	by seqn; 
run; 
proc sort data = bm.p_bmx out = bmxo; 
	by seqn; 
run; 
proc sort data = dib.p_diq out = dibg; 
	by seqn; 
run; 
proc sort data = chol.p_trigly out = tri; 
	by seqn; 
run; 

data analysis;
  merge bmxo(in=C) demog(in=A) bpx(in=B) dibg(in=D) tri(in=E);
  by seqn;
  if C;  
run;

data analysis; 
	set analysis; 
	avg_sys = mean(BPXOSY1, BPXOSY2, BPXOSY3);
	avg_dia = mean(BPXODI1, BPXODI2, BPXODI3);
run; 

proc format;
   value sexfmt
       1 = 'Male'
       2 = 'Female';

   value racefmt
       1 = 'Mexican American'
       2 = 'Other Hispanic'
       3 = 'Non-Hispanic White'
       4 = 'Non-Hispanic Black'
       6 = 'Non-Hispanic Asian'
       7 = 'Other Race - Including Multi-Racial';

   value marfmt
       1  = 'Married/Living with Partner'
       2  = 'Widowed/Divorced/Separated'
       3  = 'Never Married'
       77 = 'Refused'
       99 = "Don't Know";

   value edufmt
       1 = 'Less than 9th grade'
       2 = '9-11th grade (Includes 12th grade with no diploma)'
       3 = 'High school graduate/GED or equivalent'
       4 = 'Some college or AA degree'
       5 = 'College graduate or above'
       7 = 'Refused'
       9 = "Don't Know";

   value insfmt
       1 = 'Yes'
       2 = 'No'
       7 = 'Refused'
       9 = "Don't Know";
run;

* apply formats now; 

data analysis;
   set analysis;
   format RIAGENDR sexfmt.
          RIDRETH3 racefmt.
          DMDMARTZ marfmt.
          DMDEDUC2 edufmt.
          DIQ050   insfmt.;
run;

*to fill out the table we'll be using proc freq and proc means; 

proc means data=analysis mean std;
   class RIAGENDR;
   var RIDAGEYR BMXBMI avg_sys avg_dia DID040 LBXTR;
   format RIAGENDR sexfmt.;
run;

proc freq data=analysis;
   tables RIAGENDR*RIDRETH3 / chisq;
   tables RIAGENDR*DMDMARTZ / chisq;
   tables RIAGENDR*DMDEDUC2 / chisq;
   format RIAGENDR sexfmt.
          RIDRETH3 racefmt.
          DMDMARTZ marfmt.
          DMDEDUC2 edufmt.;
run;

proc freq data=analysis;
   tables RIAGENDR*DIQ050 / norow nocol nopercent;
   format DIQ050 insfmt.
   		  RIAGENDR sexfmt.;
run;
