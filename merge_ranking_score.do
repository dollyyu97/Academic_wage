
global name dyu

global shanghai "/Users/$name/Dropbox/Academic_Wage/Shanghai_Ranking/Data"
global data "/Users/$name/Dropbox/Academic_Wage/Data_Final"
use "$shanghai/Final_rank.dta", clear 

keep if year == 2017

*generate Field variable for merging
gen Field = ""

replace Field = "FIN" if subject == "Finance" 
replace Field = "ECO" if subject == "Economics" 
replace Field = "CS" if subject == "Computer Science & Engineering" 
replace Field = "BUSI" if subject == "Business Administration" 
replace Field = "MATH" if subject == "Mathematics"
replace Field = "PHYS" if subject == "Physics"
*IF there is Law, uncomment the following line 
replace Field = subject if subject == "LAW" 
replace Field = "HUM" if Field == ""

*generate average humanities score and ranking across three fields 
bys institution: egen ave_hum_score = mean(total_score) if Field == "HUM" 
replace total_score = ave_hum_score if Field == "HUM" 

duplicates drop institution Field ave_hum_score, force

egen new_rank = rank(ave_hum_score) if Field == "HUM", f
replace ranking = new_rank if Field == "HUM" 
drop new_rank ave_hum_score 

sort Field ranking

*More changes for better match 
gen uni_lower = lower(institution)
gen iduse = _n 
replace uni_lower = subinstr(uni_lower, "the","",.)
replace uni_lower = "univesity of washington, seattle" if uni_lower == "university of washington"
replace uni_lower = "texas tech university at lubbock" if uni_lower == "texas tech university" 
replace uni_lower = "ohio state university" if strpos(uni_lower, "ohio state") > 0
replace uni_lower = "city university of new york" if uni_lower == "city university of new york city college"
replace uni_lower = "baruch" if strpos(uni_lower, "baruch college") > 0
replace uni_lower = "university at albany state university of new york" if strpos(uni_lower, "albany") > 0
replace uni_lower = "university of missouri" if uni_lower == "university of missouri - columbia" 
*IF there is LAW, decomment the following line
save "$data\rankings_to_merge_withLAW.dta", replace 
* IF there is NO Law, decomment the following line
*save "$data\rankings_to_merge.dta", replace 

/*

gen uni_lower = lower(university) 
gen idmaster = _n

reclink2 Field uni_lower using "$dropbox/rankings_to_merge.dta", gen(myscore) idm(idmaster) idu(iduse) required(Field) minscore (0.995) manytoone 

**====Matching result======**

*3537 perfect matches found
*Unique Master Cases: matched = 5288 (exact = 3537), unmatched = 4741

drop TOP IC CNCI PUB AWARD subject 
* clean-up after fuzzy matching 
replace Uuni_lower = "" if Uuni_lower == "university of york" 
replace Uuni_lower = "" if Uuni_lower == "washington state university" & ///
						   uni_lower == "eastern washington university" 
replace Uuni_lower = "" if Uuni_lower == "northwestern university" & ///
					       uni_lower == "northwestern state university" 
replace Uuni_lower = "" if Uuni_lower == "georgia state university" & ///
					       uni_lower == "middle georgia state university" 

save preliminary_match.dta, replace
*Now: matched = 5263, unmatched = 4766

***********Pending matches*********************
*1. University of Missouri: 
*	Master: division - lafayette, moroe, or no indication of which campus 
*	Using: Columbia, St.Louise
*2. Master: University of Massachusetts System
*	Using: University of Massachusett systes-Boston 
*3. Master: State University of New York system 
*	Using: State University of New York - Buffalo/albany
*4. Master: Texas State
*5. Master: Georgia College and State University
*	Using: Georgia College, Georgia State University 
