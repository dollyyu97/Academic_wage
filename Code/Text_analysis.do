
set more off
clear all 

*global name Claire.Celerier 
global name dyu 
global input "/Users/$name/Dropbox/Academic_wage/Donation_data/DTA_data"
global output "/Users/$name/Dropbox/Academic_wage/Donation_data/Summary"
cd "$input"

use total_with_description, clear 

global fields CS ECO LAW MED PHYS MATH FIN BUSI SOC HUM

foreach var in $fields{
	gen don_`var' = 0

}
*1. If received by medical/law school, then field = MED/LAW 
replace don_LAW = 1 if specschool == "law_school"
replace don_MED = 1 if specschool == "medical_school"
replace don_MED = 1 if (strpos(lower(recipient_name), "cancer") > 0 | ///
					strpos(lower(recipient_name), "hospital") > 0 | ///
					strpos(lower(recipient_name), "medical center") > 0) & don_MED == 0
								  
*2. Split description by "."
replace description=lower(description)
split description, parse(.)

*ssc install txttool
forvalues i = 1(1)16 {
	txttool description`i', stopwords("$input/delete_char.txt") replace
}

*3. Look for the strings in each observations to determine which one to look at
forvalues i = 1(1)16{
	gen yes_`i' = .
	gen no_`i' = .
	}
	
forvalues i=1(1)16 {
	replace no_`i' = regexm(description`i', "graduated")+regexm(description`i', "firm")+regexm(description`i', "company")+regexm(description`i', "degree")+regexm(description`i', "is a professor")+regexm(description`i', "founded")
	replace description`i' = "" if no_`i' >=1
	}	


forvalues i = 1(1)16 {
	replace yes_`i' = regexm(lower(description`i'), "for")+regexm(lower(description`i'), "establish") ///
					+regexm(lower(description`i'), "construct")+regexm(lower(description`i'), "endow") ///
					+regexm(lower(description`i'), "support")+ regexm(lower(description`i'), "build") ///
					+regexm(lower(description`i'), "to create")+regexm(lower(description`i'), "to name") ///
					+regexm(lower(description`i'), "provide scholarship")+regexm(description`i', "renovate") ///
					+regexm(lower(description`i'), "to develop")+regexm(description`i', "to rename") ///
					+regexm(description`i', "to expand") 
}


	


*4. Look for keywords in each field 


local j=1
forvalues i = 1(1)16{
	replace don_MED = regexm(lower(description`i'), "pharmacy")+regexm(lower(description`i'), "mental health")+regexm(lower(description`i'), "medic")+regexm(lower(description`i'), "dentistry") + regexm(lower(description`i'), "disease")+regexm(description`i', "cancer")+regexm(description`i', "clinical")+regexm(description`i', "rehabilita")+regexm(description`i', "treatment")+regexm(description`i', "audiolo")+regexm(description`i', "nursing")+regexm(description`i', "healthcare")+regexm(description`i', "hospital") if (yes_`j' >= 1 & don_MED == 0)
	replace don_LAW = regexm(description`i', "law")+regexm(description`i', "legal") if yes_`j' >= 1 & don_LAW == 0 & don_MED == 0
	replace don_LAW = 0 if strpos(description`i', "lawyer") > 0 & yes_`j' >= 1
	replace don_ECO =regexm(lower(description`i'), "economic") if yes_`j' >= 1 & don_ECO == 0 
	replace don_FIN =regexm(lower(description`i'), "financ") if yes_`j' >= 1 & don_FIN == 0
	replace don_BUSI =regexm(lower(description`i'), "business admin")+regexm(lower(description`i'), "entrepren")+regexm(lower(description`i'), "management") +regexm(description`i', "business build")+ regexm(description`i', "business student")+regexm(description`i', "college of busi")+regexm(description`i', "schools of busi")+regexm(description`i', "school of busi")+regexm(description`i', "businesssch")+regexm(description`i', "business sch")+regexm(description`i', "accounting") +regexm(description`i', "m.b.a") if (yes_`j' >= 1 & don_BUSI == 0)
	replace don_CS =regexm(description`i',"computer sci") + regexm(description`i',"programming")+regexm(description`i', "information sci")+regexm(description`i', "computer engineer") if (yes_`j' >= 1 & don_CS == 0)
	replace don_MATH = regexm(description`i', "mathemati")+regexm(description`i', "math") if (yes_`j' >= 1 & don_MATH == 0)
	replace don_PHYS =regexm(description`i', "physics") + regexm(description`i', "astro") if (yes_`j' >= 1 & don_PHYS == 0)
	replace don_PHYS = 0 if strpos(description`i', "biophysic") & yes_`j' >= 1
	replace don_SOC = regexm(description`i', "political")+ regexm(description`i', "government") ///
					+regexm(description`i', "sociology")+regexm(description`i', "public affair") ///
					+regexm(description`i', "policy") +regexm(description`i', "social stud")///
					+regexm(description`i', "human right")+regexm(description`i', "school of education") ///
					+regexm(description`i', "teachers col") +regexm(description`i', "politics") ///
					if yes_`j' >= 1 & don_HUM == 0 & don_MED == 0 & don_LAW ==0
	replace don_HUM = regexm(description`i', "religio") +regexm(description`i', "psych") ///
					+regexm(description`i', "history")+regexm(description`i', "college of educ") ///
				    +regexm(description`i', "humanit") +regexm(description`i', "english") ///
					+regexm(description`i', "literature")+regexm(description`i', "childhood") ///
					+regexm(description`i', "global stu")+regexm(description`i', "philosophy") ///
					+regexm(description`i', "social just")+regexm(description`i', "fine art") ///
					+regexm(description`i', "department of education")+regexm(description`i', "lingustic") ///
					
					if yes_`j' >= 1 & don_HUM == 0 & don_MED == 0 & don_LAW ==0
	replace don_BIOCHEM = regexm(description`i', "chemistry") +regexm(description`i', "biolog")
	replace don_BUSI = 1 if (don_BUSI == 0 & don_FIN == 0 & specschool == "business_school")
	
	
local j = `j' + 1	
	
}

foreach var in $fields{
	replace don_`var' = 1 if don_`var' >=1
}

foreach var in $fields{
	egen donsum_`var' = sum(value) if don_`var' == 1
	tab donsum_`var'
}


gen don_missing=	don_BUSI == 0 & don_CS == 0 & don_ECO == 0 & don_FIN == 0 & don_HUM == 0 & don_LAW == 0 & don_MATH == 0 & don_MED == 0 & don_PHYS == 0
tab don_missing

br if don_missing==1
/*Check if there is any correlation in double-counting
br if don_BUSI == 1 & don_FIN == 1
br if don_BUSI == 1 & don_ECO == 1
br if don_MED == 1 & don_PHYS == 1
*Result: 0 (not missing) = 2357, 1(missing) = 3559

*/

save "$input/data_with_donation_fields.dta", replace 


*=============================Reshape the data to donation-field level ob==================*

use "$input/data_with_donation_fields.dta", clear

global fields CS ECO LAW MED PHYS MATH FIN BUSI HUM
keep year name donor* value recipient* type description don_* specschool
keep if don_missing != 1
drop don_missing

foreach var in $fields{
	replace don_`var' =0 if don_`var' == .
}
local i=1
foreach var in $fields {
	ren don_`var' subject_`i'
	local i= `i'+1
	}
	
reshape long subject, i(name year description recipient_name value) j(field) string
drop if subject == 0
duplicates tag name year recipient_name description value, gen(dup)
gsort -dup year name
replace value = value/(dup+1)

local i=1
foreach var in $fields{
	replace field ="`var'" if field == "_`i'"
	local i =`i' +1
}

drop dup subject 
save "$input/reshaped_donation_with_fields.dta", replace

preserve
bysort field: gen tag_1 = _n 
collapse (max) num_field=tag_1 (sum)total_donation=value, by(field)
drop if field == "MED"
save "$output/field_count.dta", replace

restore


*----------------------Other purposes of donation------------------------------*

keep if don_missing ==1 
local j=1
forvalues i = 1(1)16{
	replace don_sport = regexm(description`i', "athelet")+regexm(description`i', "golf") ///
						+regexm(description`i', "strength") +regexm(description`i', "stadium") ///
						+regexm(description`i', "football") +regexm(description`i', "basketball") ///
						
	replace don_art_music = regexm(description`i', "music") + regexm(description`i', "performance") ///
	replace don_general = regexm(description`i', "library") + regexm(description`i', "facilities") ///
						+regexm(description`i', "unrestrict") +
	replace don_MATH = regexm(description`i', "mathemati")+regexm(description`i', "math") if (yes_`j' >= 1 & don_MATH == 0)
	replace don_PHYS =regexm(description`i', "physics") + regexm(description`i', "astro") if (yes_`j' >= 1 & don_PHYS == 0)
	replace don_PHYS = 0 if strpos(description`i', "biophysics")
	replace don_HUM = regexm(description`i', "political")+ regexm(description`i', "government") ///
					+regexm(description`i', "sociology")+regexm(description`i', "public affair") ///
					+regexm(description`i', "social stud")+regexm(description`i', "policy") ///
					+regexm(description`i', "human right")+regexm(description`i', "school of education") ///
					+regexm(description`i', "teachers col")+regexm(description`i', "religio") ///
					+regexm(description`i', "psych") ///
					+regexm(description`i', "history")+regexm(description`i', "college of educ") ///
				    +regexm(description`i', "humanit") +regexm(description`i', "english") ///
					+regexm(description`i', "literature")+regexm(description`i', "childhood") ///
					if (yes_`j' >= 1 & don_HUM == 0)
*education is difficult to distinguish
	
	
local j = `j' + 1	
	
}


