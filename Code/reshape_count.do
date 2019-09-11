set more off 
clear all 

global name dyu
global output "/Users/$name/Dropbox/Academic_Wage/Donation_data/Summary" 
global data "/Users/$name/Dropbox/Academic_Wage/Donation_data/DTA_data"

cd "$data" 


use "total_with_description.dta", clear 

*===========================Specialization school==================================*

***AT this stage there is no reshape happening

*Generate the categorical variable for specschool
gen specschool = ""
replace specschool = "business_school" if strpos(lower(recipient_name), "business") > 0 | strpos(lower(recipient_name), "management") > 0 | strpos(lower(recipient_name), "wharton") > 0 | strpos(lower(recipient_name), "commerce") > 0

replace specschool = "law_school" if strpos(lower(recipient_name), "law") > 0
replace specschool = "" if lower(recipient_name) == "lawrence u."

replace specschool = "medical_school" if strpos(lower(recipient_name), "medicine") > 0 | strpos(lower(recipient_name), "medical school") > 0 | strpos(lower(recipient_name), "physician") > 0 | strpos(lower(recipient_name), "dentistry") > 0 | strpos(lower(recipient_name), "medical science") > 0

replace specschool = "engineering_school" if strpos(lower(recipient_name), "engineer") > 0 | strpos(lower(recipient_name), "applied science") > 0

replace specschool = "none" if specschool == ""

save "$data/total_with_description.dta", replace
preserve

bysort specschool: gen tag_2 = _n
collapse (max)num_school=tag (sum) total_donation=value, by(specschool)
save "$output/specschool_count.dta", replace

restore


*=================Create dummy variables for donor_industry======================*

* Accounts for double-counting of donor's industry
gen agriculture = 1 if strpos(lower(donor_industry), "agriculture") > 0
gen education = 1 if strpos(lower(donor_industry), "education") > 0 
gen construction  = 1 if strpos(lower(donor_industry), "construction") > 0
gen entertainment = 1 if strpos(lower(donor_industry), "entertainment") > 0
gen advertising = 1 if strpos(lower(donor_industry), "advertising") > 0
gen commodities = 1 if strpos(lower(donor_industry), "commodities") > 0 | ///
					   strpos(lower(donor_industry), "food") > 0
						
gen consulting = 1 if strpos(lower(donor_industry), "consulting") > 0
gen finance = 1 if strpos(lower(donor_industry), "finance") > 0 
gen energy =1 if strpos(lower(donor_industry), "energy") > 0 | ///
				 strpos(lower(donor_industry), "oil") > 0 | ///
				 strpos(lower(donor_industry), "mineral") > 0 
				 
gen family_wealth = 1 if strpos(lower(donor_industry), "family wealth") > 0
gen investment = 1 if strpos(lower(donor_industry), "investments") > 0
gen realestate = 1 if strpos(lower(donor_industry), "real estate") > 0
gen healthcare = 1 if strpos(lower(donor_industry), "health") > 0 | ///
					  strpos(lower(donor_industry), "pharm") > 0 

gen manufacturing = 1 if strpos(lower(donor_industry), "manufactur") > 0
gen law = 1 if strpos(lower(donor_industry), "law") > 0 
gen retail = 1 if strpos(lower(donor_industry), "retail") > 0 
gen government = 1 if strpos(lower(donor_industry), "govern") > 0 
gen insurance = 1 if strpos(lower(donor_industry), "insurance") > 0
gen transportation = 1 if strpos(lower(donor_industry), "transport") > 0 
gen technology = 1 if strpos(lower(donor_industry), "technology") > 0 | ///
					  strpos(lower(donor_industry), "telecommunication") > 0
gen industries = 1 if strpos(lower(donor_industry), "industry") > 0 | ///
					strpos(lower(donor_industry), "chemical") > 0 | ///
					strpos(lower(donor_industry), "engineer") > 0 
					
gen sports = 1 if strpos(lower(donor_industry), "sport") > 0 
gen unspecified = 1 if donor_industry == ""

sort name year

global indus agriculture education construction entertainment advertising ///
			commodities consulting finance energy family_wealth investment ///
			realestate healthcare manufacturing law retail government insurance ///
			transportation technology industries sports unspecified
			
foreach var in $indus{
	replace `var' = 0 if `var' == . 
}
local i=1

*Reshape the data, so two entries per donor-year if the donor is in two industries

foreach var in $indus{
	ren `var' area`i'
	local i=`i'+1
}

reshape long area, i(name year description recipient_name value) j(industry)
drop if area == 0 


gen donor_indus = ""
local i=1
foreach var in $indus{
	replace donor_indus ="`var'" if industry == `i'
	local i =`i' +1
}


drop area industry
ren name donor_name 
save "$data/reshaped_total_with_description.dta", replace

preserve

bysort donor_indus: gen tag_1 = _n 
collapse (max) num_industry=tag_1 (sum)total_donation=value, by(donor_indus)
save "$output/industry_count.dta", replace

restore
/*
*generate vector of counts
mat B = (.)
foreach var in `indus' {
	count if `var' == 1
	mat B = (B \ r(N))
}

matname B `indus', rows(2..23)
mat colnames B =  count
mat list B

*generate vector of sum of donation under each industry 
mat A = (.)
foreach var in `indus' {
	egen all_`var' = total(value) if `var' == 1 
	gsort all_`var'
	mat A = (A \ all_`var'[1])
}

matname A "value" , c(1)

*List matrix in Stata
mat industry_sum = (B, A)
mat list industry_sum
*Export matrix to excel for illustration
putexcel set "industry_count.xls", replace
putexcel A1 = mat(B), names
putexcel C1 = mat(A), colnames

restore 
*/



