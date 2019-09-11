
clear all 

global name Claire.Celerier
global data "/Users/$name/Dropbox/Academic_Wage/Donation_data/Raw_excel" 
global output "/Users/$name/Dropbox/Academic_Wage/Donation_data/DTA_data" 

cd "$data"
*=======================Data without decription============================*
fs "donate_*.xlsx" 

foreach i in `r(files)' {
	import excel "`i'", firstrow clear
	drop Description GiftValue
	save "`i'.dta", replace 
}

clear 

fs "donate_*.dta"
append using `r(files)'

save "$output/total_without_description.dta", replace

fs "donate_*.dta" 
foreach i in `r(files)' {
	erase "`i'"
}

*==================================With Description=====================*
clear all

local run1 1

if `run1' == 1 {

fs "donate_*.xlsx"

foreach i in `r(files)' {
	import excel "`i'", firstrow clear
	drop GiftValue 
	save "des`i'.dta", replace 
}

clear 
fs "des*.dta"
append using `r(files)'

ren Description description


fs "des*.dta" 
foreach i in `r(files)' {
	erase "`i'"
}

}
*=======================================================================*
*Clean the data with description
drop K
gen name = Donor + Donor1 
assert name != ""
drop Donor Donor1 
order year name, first

ren Recipient1 recipient_name 
ren Recipient2 recipient_location 
ren GiftType type 

ren WhereDonor donor_location 
ren DonorsSource donor_industry 

replace name = "" if strpos(lower(name), "anonymous") > 0
duplicates drop 
*drop error entry from the website
drop if name == "James Antoniono and Susan Antoniono" & year == 2014 & type == "Gift"


*===========================Specialization school==================================*

***AT this stage there is no reshape happening

*Generate the categorical variable for specschool
gen specschool = ""
replace specschool = "business_school" if strpos(lower(recipient_name), "business") > 0 | strpos(lower(recipient_name), "management") > 0 | strpos(lower(recipient_name), "wharton") > 0 | strpos(lower(recipient_name), "commerce") > 0

replace specschool = "law_school" if strpos(lower(recipient_name), "law") > 0

replace specschool = "medical_school" if strpos(lower(recipient_name), "medicine") > 0 | strpos(lower(recipient_name), "medical school") > 0 | strpos(lower(recipient_name), "physician") > 0 | strpos(lower(recipient_name), "dentistry") > 0 | strpos(lower(recipient_name), "medical science") > 0

replace specschool = "engineering_school" if strpos(lower(recipient_name), "engineer") > 0 | strpos(lower(recipient_name), "applied science") > 0

replace specschool = "none" if specschool == ""


save "$output/total_with_description.dta", replace 




/*
gen biz_school = 1 if strpos(lower(recipient_name), "business") > 0 | ///
					  strpos(lower(recipient_name), "management") > 0 | ///
					  strpos(lower(recipient_name), "wharton") > 0 | ///
					  strpos(lower(recipient_name), "commerce") > 0
gen law_school = 1 if strpos(lower(recipient_name), "law") > 0
gen med_school = 1 if strpos(lower(recipient_name), "medicine") > 0 | ///
					  strpos(lower(recipient_name), "medical school") > 0 | ///
					  strpos(lower(recipient_name), "physician") > 0 | ///
					  strpos(lower(recipient_name), "dentistry") > 0 | ///
					  strpos(lower(recipient_name), "medical science") > 0
gen engineering_school = 1 if strpos(lower(recipient_name), "engineer") > 0 | ///
							  strpos(lower(recipient_name), "applied science") > 0


local specschool biz_school law_school med_school engineering_school 

collapse (count)`specschool' (sum) total_donation=value

reserve 

*generate vector of counts
foreach val in `specschool' {
	egen `val'_count = total(`val')
}

mat C = (. \ biz_school_count[1] \ law_school_count[1] \ med_school_count[1] \ ///
		 engineering_school_count[1]) 
mat rownames C = none biz_school law_school med_school engineering_school
mat colnames C = count 
mat list C

*generate vector of sum of donation under each category
mat D = (.)
foreach val in `specschool' {
	egen all_`val' = total(value) if `val' == 1
	gsort -all_`val'
	mat D = (D \ all_`val'[1])
}

mat colnames D = value 
*List the matrix in Stata
mat school_sum = (C, D)
mat list school_sum
*Export matrix to excel for illustration
putexcel set "schools_count.xls", replace
putexcel A1 = mat(C), names
putexcel C1 = mat(D), colnames

restore
