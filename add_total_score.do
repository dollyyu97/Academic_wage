
clear all 
set more off 
set scheme s2mono 
capture log close 

global name dyu 
global data "/Users/$name/Dropbox/Academic_Wage/Shanghai_Ranking/Data"

use "$data/BA-total.dta", clear

foreach sub in Fin Econ CS Maths Phy Poli Socio Educ Law { 
	append using "$data/`sub'-total.dta", force
} 


*check if all obs are imported
tab subject year

replace total_score = 1.5*PUB + 0.5*CNCI + 0.1*IC+ TOP if subject == "Finance" 
													   
replace total_score = 1.5*PUB + 0.5*CNCI + 0.1*IC+ TOP +AWARD if subject == "Economics"

replace total_score = 1.5*PUB + 0.5*CNCI + 0.1*IC + TOP if subject ==  "Business Administration" ///
														& year != 2017
replace total_score = 1.5*PUB + 0.5*CNCI + 0.1*IC + 1.5*TOP if subject ==  "Business Administration" ///
														& year == 2017


replace total_score = PUB + CNCI + 0.2*IC + TOP+ AWARD if subject == "Mathematics"
replace total_score = PUB + CNCI + 0.2*IC + TOP+ AWARD if subject == "Physics"

replace total_score = PUB + CNCI + 0.2*IC + TOP + AWARD if subject == "Computer Science & Engineering" ///
												& year != 2017
												
replace total_score = PUB + CNCI + 0.2*IC + 0.2*TOP + 1.8*AWARD if subject == "Computer Science & Engineering" ///
												                & year == 2017
replace total_score = 1.5*PUB + 0.5*CNCI + 0.1*IC +1.5*TOP if subject == "Education" | ///
															  subject == "Political Sciences" | ///
															  subject == "Sociology" | ///
															  subject == "LAW" 

assert total_score != . 

* Generate new ranking according to calculated total score
bysort subject year: egen ranking = rank(total_score), f
sort subject year ranking

order ranking, first 
drop rank 

save "$data/Final_rank.dta", replace


