*****Step 1: Primary Structure

***Call
quietly{
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"capital return")+regexm(description_`i',"guarantee")+regexm(description_`i',"minimum return")+regexm(description_`i',"minimum capital return")+regexm(description_`i',"capital protection")+regexm(description_`i',"capital back")+regexm(description_`i',"% of the capital invested")+regexm(description_`i',"initial investment")+regexm(description_`i',"full return of capital")+regexm(description_`i',"maximum between 100%")+regexm(description_`i',"100% of the initial capital")+regexm(description_`i',"100% of their initial capital")+regexm(description_`i',"a return of minimum 100%")+regexm(description_`i',"100% capital")+regexm(description_`i',"return of 100%")+regexm(description_`i',"offering 100%")+regexm(description_`i',"offering a minimum of 100%")+regexm(description_`i',"of investors' capital")+regexm(description_`i',"100% of investors'initial capital")+regexm(description_`i',"with a minimum of")
replace sum2=regexm(description_`i',"plus")+regexm(description_`i',"with")+regexm(description_`i',"or")+regexm(description_`i',"and offers")+regexm(description_`i',"product returns")+regexm(description_`i',"product offers")+regexm(description_`i',"and an interest")+regexm(description_`i',"the return of the capital")+regexm(description_`i',"and the greater")+regexm(description_`i',"and a participation of")+regexm(description_`i',"maturity and")+regexm(description_`i',"investment and")+regexm(description_`i',"participates")+regexm(description_`i',"participants receive")
replace sum3=regexm(description_`i',"rise")+regexm(description_`i',"growth")+regexm(description_`i',"participation")+regexm(description_`i',"growth")+regexm(description_`i',"performance")+regexm(description_`i',"the upside of")+regexm(description_`i',"of the average growth in")+regexm(description_`i',"the performance of")+regexm(description_`i',"the appreciation of")+regexm(description_`i',"upside participation")+regexm(description_`i',"% of the best performing")+regexm(description_`i',"of the fall in value of the euro compared to")
replace newp=newp+", call" if sum1>=1&sum2>=1&sum3>=1&newp!=""&regexm(newp,"call")==0
replace newp="call" if sum1>=1&sum2>=1&sum3>=1&newp==""
} 
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"the greater between")+regexm(description_`i',"the greater of")+regexm(description_`i',"the maximum")
replace sum2=regexm(description_`i',"102.5% capital")+regexm(description_`i',"101% of the capital")+regexm(description_`i',"128% of the initial capital invested")+regexm(description_`i',"100%")+regexm(description_`i',"performance of the underlying")+regexm(description_`i',"participation")
replace sum3=regexm(description_`i',"% of the rise")+regexm(description_`i',"% of the highest value")+regexm(description_`i',"% of the index rise")+regexm(description_`i',"the final level")+regexm(description_`i',"start date")+regexm(description_`i',"in the rise")+regexm(description_`i',"strengthening")+regexm(description_`i',"perf")
replace newp=newp+", call" if sum1>=1&sum2>=1&sum3>=1&newp!=""&regexm(newp,"call")==0
replace newp="call" if sum1>=1&sum2>=1&sum3>=1&newp==""
} 
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"participation")+regexm(description_`i',"investor receives")+regexm(description_`i',"participate")+regexm(description_`i',"product returns")
replace sum2=regexm(description_`i',"the difference")+regexm(description_`i',"performance")+regexm(description_`i',"in the sum of")+regexm(description_`i',"the highest")+regexm(description_`i',"100% of")+regexm(description_`i',"90% of")+regexm(description_`i',"50% of")
replace sum3=regexm(description_`i',"final level and the initial level")+regexm(description_`i',"cap level and the initial level")+regexm(description_`i',"underlying")+regexm(description_`i',"the basket")+regexm(description_`i',"the share performance")+regexm(description_`i',"gold")+regexm(description_`i',"averaged performance")+regexm(description_`i',"growth")
replace newp=newp+", call" if sum1>=1&sum2>=1&sum3>=1&newp!=""&regexm(newp,"call")==0
replace newp="call" if sum1>=1&sum2>=1&sum3>=1&newp==""
} 
 
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"the product offers")+regexm(description_`i',"growth is based")+regexm(description_`i',"investors receive")
replace sum2=regexm(description_`i',"the appreciation of")+regexm(description_`i',"any rise of")+regexm(description_`i',"participation in the rise")+regexm(description_`i',"performance")+regexm(description_`i',"growth")+regexm(description_`i',"returns")
replace sum3=regexm(description_`i',"against")+regexm(description_`i',"index")+regexm(description_`i',"of the basket")+regexm(description_`i',"underlying")+regexm(description_`i',"basket growth")+regexm(description_`i',"of the weighted basket")
replace newp=newp+", call" if sum1>=1&sum2>=1&sum3>=1&newp!=""&regexm(newp,"call")==0
replace newp="call" if sum1>=1&sum2>=1&sum3>=1&newp==""
} 

replace sum1=0
replace sum2=0

forvalues i=1(1)17 {
replace sum1=sum1+regexm(description_`i',"capital return of 100%")+regexm(description_`i',"capital return at maturity of 100%")+regexm(description_`i',"a minimum return of 100%")+regexm(description_`i',"% capital return")+regexm(description_`i',"capital guaranteed")+regexm(description_`i',"offers the capital invested")+regexm(description_`i',"guarantees the return of the capital invested")+regexm(description_`i',"100% of the capital invested")+regexm(description_`i',"offering 100%")+regexm(description_`i',"offers 100%")+regexm(description_`i',"return at maturity is 100%")
replace sum2=sum2+regexm(description_`i',"participation in the rise of the index")+regexm(description_`i',"growth product linked to")+regexm(description_`i',"growth product is linked to")+regexm(description_`i',"bonus is reduced 1:1 for any fall ")+regexm(description_`i',"% of any rise in")+regexm(description_`i',"% of strengthening")+regexm(description_`i',"participates 100% in the positive performance")+regexm(description_`i',"participation in the final index performance")+regexm(description_`i',"participation in the final positive index performance")+regexm(description_`i',"level of revaluation")+regexm(description_`i',"% of the index performance")+regexm(description_`i',"% of the rise in")+regexm(description_`i',"% of any rise in")
replace newp=newp+", call" if sum1>=1&sum2>=1&newp!=""&regexm(newp,"call")==0
replace newp="call" if sum1>=1&sum2>=1&newp==""
} 

forvalues i=1(1)17 {
replace sum1=sum1+regexm(description_`i',"participation in the growth of the dollar")
replace newp=newp+", call" if sum1>=1&newp!=""&regexm(newp,"call")==0
replace newp="call" if sum1>=1&newp==""
} 

forvalues i=1(1)17 {
replace sum1=sum1+regexm(description_`i',"a coupon equal to 100% of the rise of the index")
replace newp=newp+", call" if sum1>=1&prtype==1&newp!=""&regexm(newp,"call")==0
replace newp="call" if sum1>=1&prtype==1&newp==""
} 
replace newp=newp+"call" if regexm(name,"call")&regexm(newp,"call")==0

forvalues i=1(1)17 {
replace sum1=regexm(description_`i'," sum ")+regexm(description_`i'," sums ")+regexm(description_`i'," average ")
replace sum2=regexm(description_`i',"annual")+regexm(description_`i',"yearly")+regexm(description_`i',"registered")+regexm(description_`i',"monthly")+regexm(description_`i',"quarterly")+regexm(description_`i',"month-to-month")+regexm(description_`i',"month-on-month")+regexm(description_`i',"these")+regexm(description_`i',"the percentage")+regexm(description_`i',"of all")
replace sum3=regexm(description_`i',"performance")+regexm(description_`i',"returns")+regexm(description_`i',"readings")+regexm(description_`i',"growth")+regexm(description_`i',"rise")+regexm(description_`i',"observations")+regexm(description_`i',"measurements")
replace sum4=regexm(description_`i',"cliquet")
replace newp="call" if sum1>=1&sum2>=1&sum3>=1
replace newp="call" if sum4>=1
} 

}

***Floater
quiet{
replace prtype=3 if regexm(description_1,"income")

forvalues i=1(1)17 {
*replace sum1=regexm(description_`i',"quarterly")+regexm(description_`i',"quaterly")+regexm(description_`i',"every year")+regexm(description_`i',"every quarter")+regexm(description_`i',"each year")+regexm(description_`i',"annual")+regexm(description_`i',"following years")
replace sum2=regexm(description_`i',"coupon")+regexm(description_`i',"income")-regexm(description_`i',"growth and income product")
replace sum3=regexm(description_`i',"equal to")+regexm(description_`i',"attributed")+regexm(description_`i',"calculated as")+regexm(description_`i',"paid out")+regexm(description_`i',"equivalent to")+regexm(description_`i',"which equals")+regexm(description_`i',"will be the average")+regexm(description_`i',"linked to")+regexm(description_`i',"registered as")
replace sum4=regexm(description_`i',"3 month gbp libor")+regexm(description_`i',"performance")+regexm(description_`i',"participation")+regexm(description_`i',"level")+regexm(description_`i',"rise")+regexm(description_`i',"90% of")+regexm(description_`i',"the eur")+regexm(description_`i',"the 3-months eur")+regexm(description_`i',"swap rate")+regexm(description_`i',"euribor")+regexm(description_`i',"the underlying")+regexm(description_`i',"the smr-bund")+regexm(description_`i',"the cms")+regexm(description_`i',"readings")
replace sum5=regexm(description_`i',"inflation")+regexm(description_`i',"the eur swap rate")+regexm(description_`i',"growth")+regexm(description_`i',"variable coupon")+regexm(description_`i',"90% of")+regexm(description_`i',"the eur")+regexm(description_`i',"the 3-months eur")+regexm(description_`i',"swap rate")+regexm(description_`i',"euribor")+regexm(description_`i',"the underlying")+regexm(description_`i',"the smr-bund")+regexm(description_`i',"the cms")+regexm(description_`i',"readings")+regexm(description_`i',"cibor")+regexm(description_`i',"annualised")
replace newp=newp+", floater" if prtype==3&sum2>=1&sum3>=1&(sum4>=1|sum5>=1)&newp!=""&regexm(newp,"floater")==0
replace newp="floater" if prtype==3&sum2>=1&sum3>=1&(sum4>=1|sum5>=1)&newp==""
} 
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"quarterly")+regexm(description_`i',"quaterly")+regexm(description_`i',"every year")+regexm(description_`i',"every quarter")+regexm(description_`i',"each year")+regexm(description_`i',"annual")+regexm(description_`i',"following years")
replace sum2=regexm(description_`i',"offers the 3-mth stibor rate")+regexm(description_`i',"offers a coupon calculated as the 3-months")
replace newp=newp+", floater" if prtype==3&sum1>=1&sum2>=1&newp!=""&regexm(newp,"floater")==0
replace newp="floater" if prtype==3&sum1>=1&sum2>=1&newp==""
} 
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"quarterly")+regexm(description_`i',"quaterly")+regexm(description_`i',"every year")+regexm(description_`i',"every quarter")+regexm(description_`i',"each year")+regexm(description_`i',"annual")+regexm(description_`i',"following years")+regexm(description_`i',"each period")
replace sum2=regexm(description_`i',"coupon")
replace sum3=regexm(description_`i',"% of the rise in")+regexm(description_`i',"participation in")
replace sum4=regexm(description_`i',"guarantees the return")+regexm(description_`i',"the product pays")
replace newp=newp+", floater" if prtype==3&sum1>=1&sum2>=1&sum3>=1&sum4>=1&newp!=""&regexm(newp,"floater")==0
replace newp="floater" if prtype==3&sum1>=1&sum2>=1&sum3>=1&sum4>=1&newp==""
} 
replace newp=subinstr(newp,", call","",.) if regexm(newp,"call") & regexm(newp,"floater")
replace newp=subinstr(newp,"call, ","",.) if regexm(newp,"call") & regexm(newp,"floater")
}


***Altiplano
quietly{
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"underlying")+regexm(description_`i',"index")+regexm(description_`i',"indices")+regexm(description_`i',"share")+regexm(description_`i',"companies")+regexm(description_`i',"stocks")+regexm(description_`i'," eurostoxx50")+regexm(description_`i',"share")
replace sum2=regexm(description_`i',"above")+regexm(description_`i',"higher")+regexm(description_`i',"by more")+regexm(description_`i',"below")+regexm(description_`i',"fell by more")+regexm(description_`i',"has never reached")+regexm(description_`i',"remain solvent")+regexm(description_`i',"has fallen")+regexm(description_`i',"exceeds")+regexm(description_`i',"dependent on")+regexm(description_`i',"equal to")
replace sum3=regexm(description_`i',"offer")+regexm(description_`i',"pays")+regexm(description_`i',"paid out")+regexm(description_`i',"register")+regexm(description_`i',"is attributed")+regexm(description_`i',"is paid")+regexm(description_`i',"is set at")+regexm(description_`i',"the return")
replace sum4=regexm(description_`i',"coupon")+regexm(description_`i',"growth of")+regexm(description_`i',"p.a.")+regexm(description_`i',"for the year")
replace sum5=regexm(description_`i',"variable")
replace sum6=regexm(description_`i',"matures early")
replace newp=newp+", altiplano" if sum1>=1&sum2>=1&sum3>=1&sum4>=1&sum5==0&sum6==0&newp!=""&regexm(newp,"altiplano")==0
replace newp="altiplano" if sum1>=1&sum2>=1&sum3>=1&sum4>=1&sum5==0&sum6==0&newp==""
} 
replace sum5=0
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"underlying")+regexm(description_`i',"index")+regexm(description_`i',"indices")+regexm(description_`i',"share")+regexm(description_`i',"if the dj")+regexm(description_`i',"depending on")
replace sum2=regexm(description_`i',"above")+regexm(description_`i',"within")+regexm(description_`i',"higher")+regexm(description_`i',"below")+regexm(description_`i',"hasn't risen more")+regexm(description_`i',"have risen")+regexm(description_`i',"has broken")+regexm(description_`i',"lower")
replace sum3=regexm(description_`i',"offer")+regexm(description_`i',"pays")+regexm(description_`i',"records")+regexm(description_`i',"paid out")+regexm(description_`i',"is set at ")+regexm(description_`i',"is calculated as")+regexm(description_`i',"register")
replace sum4=regexm(description_`i',"coupon")+regexm(description_`i',"return")
replace sum5=sum5+regexm(description_`i',"every year")+regexm(description_`i',"every day")+regexm(description_`i',"for that year")+regexm(description_`i',"each year")+regexm(description_`i',"next two years")
replace newp=newp+", altiplano" if sum1>=1&sum2>=1&sum3>=1&sum4>=1&sum5>=1&newp!=""&regexm(newp,"altiplano")==0
replace newp="altiplano" if sum1>=1&sum2>=1&sum3>=1&sum4>=1&sum5>=1&newp==""
}
replace newp=subinstr(newp,", call","",.) if regexm(newp,"call") & regexm(newp,"altiplano")
replace newp=subinstr(newp,"call, ","",.) if regexm(newp,"call") & regexm(newp,"altiplano")
replace newp=subinstr(newp,", floater","",.) if regexm(newp,"floater") & regexm(newp,"altiplano")
replace newp=subinstr(newp,"floater, ","",.) if regexm(newp,"floater") & regexm(newp,"altiplano")

}


***Digital
quiet{
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"below")+regexm(description_`i',"above")+regexm(description_`i',"higher")+regexm(description_`i',"fall")+regexm(description_`i',"risen")+regexm(description_`i',"has registered a variation")+regexm(description_`i',"has strengthened")+regexm(description_`i',"credit event")+regexm(description_`i',"trigger event")+regexm(description_`i',"if the euribor is at")+regexm(description_`i',"none of the companies default")+regexm(description_`i',"does not default")+regexm(description_`i',"remains solvent")+regexm(description_`i',"exceeds")+regexm(description_`i',"between")+regexm(description_`i',"has never been reached")+regexm(description_`i',"outperforms")+regexm(description_`i',"registered")+regexm(description_`i',"recorded")+regexm(description_`i',"greater")
replace sum2=regexm(description_`i',"barrier")+regexm(description_`i',"level")+regexm(description_`i',"more than")+regexm(description_`i',"between")+regexm(description_`i',"by at least")+regexm(description_`i',"initial level")+regexm(description_`i',"strike")+regexm(description_`i',"or more")+regexm(description_`i',"occurs")+regexm(description_`i',"have occured")+regexm(description_`i',"if the euribor is at")+regexm(description_`i',"initial one")+regexm(description_`i',"as long as")+regexm(description_`i',"if none of")+regexm(description_`i',"if all of")+regexm(description_`i',"valuation")+regexm(description_`i',"the company")+regexm(description_`i',"both shares")+regexm(description_`i',"initial value")+regexm(description_`i',"by")+regexm(description_`i',"performance")+regexm(description_`i',"all the shares")
replace sum3=regexm(description_`i',"predetermined coupon")+regexm(description_`i',"capital return")-regexm(description_`i',"100%")+regexm(description_`i',"capital back")+regexm(description_`i',"initial capital")+regexm(description_`i',"a return valued at")+regexm(description_`i',"coupon")+regexm(description_`i',"% return")+regexm(description_`i',"return as long as")+regexm(description_`i',"bonus")+regexm(description_`i'," of the initial investment")+regexm(description_`i'," of their invested capital")+regexm(description_`i',"capital return")+regexm(description_`i',"% of the nominal invested")+regexm(description_`i',"the product returns")+regexm(description_`i',"the product guarantees")+regexm(description_`i',"the cap amount")+regexm(description_`i',"a return of")+regexm(description_`i',"a return equal to")+regexm(description_`i',"a fixed")+regexm(description_`i',"the capital invested")
replace sum4=regexm(description_`i',"maturity")+regexm(description_`i',"during investment")+regexm(description_`i',"during the investment")+regexm(description_`i',"during a set period")+regexm(description_`i',"throughout investment")+regexm(description_`i',"the product offers")
replace sum5=regexm(description_`i',"including maturity")+regexm(description_`i',"matures early")+regexm(description_`i',"participation in")
replace newp=newp+", digital" if sum1>=1&sum2>=1&sum3>=1&sum4>=1&sum5==0&newp!=""&regexm(newp,"digital")==0&regexm(newp,"call")==0
replace newp="digital" if sum1>=1&sum2>=1&sum3>=1&sum4>=1&sum5==0&newp==""
} 

forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"if the product did not terminate early")+regexm(description_`i',"if this condition is met at maturity")+regexm(description_`i',"if the product did not mature")+regexm(description_`i',"continues until maturity")+regexm(description_`i',"if the condition is met")+regexm(description_`i',"if at maturity the level of the underlying reaches")
replace sum2=regexm(description_`i',"offers")+regexm(description_`i',"the investor receive")+regexm(description_`i',"investors receive")+regexm(description_`i',"coupon is attributed")
replace sum3=regexm(description_`i',"of the initial level")+regexm(description_`i',"of their initial capital")+regexm(description_`i',"of their invested capital")+regexm(description_`i',"% if")+regexm(description_`i',"capital is returned")+regexm(description_`i',"capital return")
replace newp=newp+", digital" if sum1>=1&sum2>=1&sum3>=1&newp!=""&regexm(newp,"digital")==0
replace newp="digital" if sum1>=1&sum2>=1&sum3>=1&newp==""
} 
forvalues i=1(1)17 {
replace sum1=sum1+regexm(description_`i',"growth product linked to the performance of")+regexm(description_`i',"growth product is linked to the performance of")+regexm(description_`i',"the product offers")+regexm(description_`i',"this product is linked to")+regexm(description_`i',"offers 100% capital guarantee")
replace sum2=regexm(description_`i',"and pays a fixed coupon")+regexm(description_`i',"a fixed coupon")+regexm(description_`i',"a coupon of")+regexm(description_`i',"plus a coupon which")+regexm(description_`i',"maximum total return of")
replace sum3=regexm(description_`i',"at maturity")+regexm(description_`i',"at the end of the investment period")
replace newp=newp+", digital" if sum1>=1&sum2>=1&sum3>=1&newp!=""&regexm(newp,"digital")==0
replace newp="digital" if sum1>=1&sum2>=1&sum3>=1&newp==""
} 

forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"digital")
replace newp=newp+", digital" if sum1>=1&newp!=""&regexm(newp,"digital")==0
replace newp="digital" if sum1>=1&newp==""
} 
replace newp="digital" if (regexm(name,"discount")|regexm(name,"express"))&regexm(name,"zertificat")&regexm(newp,"altiplano")==0
replace newp="digital" if (regexm(name,"discount")|regexm(name,"express"))&regexm(name,"zertifikat")&regexm(newp,"altiplano")==0

replace newp=subinstr(newp,", call","",.) if regexm(newp,"call") & regexm(newp,"digital")&regexm(name,"call")==0
replace newp=subinstr(newp,"call, ","",.) if regexm(newp,"call") & regexm(newp,"digital")&regexm(name,"call")==0
replace newp=subinstr(newp,", digital","",.) if regexm(newp,"call") & regexm(newp,"digital")&regexm(name,"call")==1
replace newp=subinstr(newp,", digital","",.) if regexm(newp,"altiplano") & regexm(newp,"digital")
replace newp=subinstr(newp,"digital, ","",.) if regexm(newp,"altiplano") & regexm(newp,"digital")
replace newp=subinstr(newp,", floater","",.) if regexm(newp,"floater") & regexm(newp,"digital")
replace newp=subinstr(newp,"floater, ","",.) if regexm(newp,"floater") & regexm(newp,"digital")

}



***Pure Income
quiet{
replace sum5=0
forvalues i=1(1)17 {
replace sum5=sum5+regexm(description_`i',"100% capital return")+regexm(description_`i',"100% of the nominal amount")+regexm(description_`i',"100% capital back")+regexm(description_`i',"return of 100%")
} 
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"the product offers")+regexm(description_`i',"the product pays")+regexm(description_`i',"is paid")+regexm(description_`i',"to pay")+regexm(description_`i',"fixed")+regexm(description_`i',"aims to pay")
replace sum2=regexm(description_`i',"coupon")+regexm(description_`i',"income")
replace sum3=regexm(description_`i',"annual")+regexm(description_`i',"p.a")+regexm(description_`i',"quarterly")+regexm(description_`i',"per annum")+regexm(description_`i',"every year")+regexm(description_`i',"every period")+regexm(description_`i',"half-yearly")
replace sum4=regexm(description_`i',"fixed")+regexm(description_`i',"income of")+regexm(description_`i',"coupon of")+regexm(description_`i',"% per annum")+regexm(description_`i',"equal to")
replace sum5=regexm(description_`i',"if")+regexm(description_`i',"the first")
replace newp=newp+", pincome" if sum1>=1&sum2>=1&sum3>=1&sum4>=1&sum5==0&newp!=""&regexm(newp,"pincome")==0
replace newp="pincome" if sum1>=1&sum2>=1&sum3>=1&sum4>=1&sum5==0&newp==""
} 
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"the product offers a fixed coupon paid at maturity")+regexm(description_`i',"a fixed coupon of 9.25% p.a.")+regexm(description_`i',"the product offers a fixed coupon, paid quarterly")
replace newp="pincome" if sum1>=1
} 

replace newp=subinstr(newp,", pincome","",.) if regexm(newp,"floater") & regexm(newp,"pincome")
replace newp=subinstr(newp,"pincome, ","",.) if regexm(newp,"floater") & regexm(newp,"pincome")
replace newp=subinstr(newp,", digital","",.) if regexm(newp,"digital") & regexm(newp,"pincome")
replace newp=subinstr(newp,"digital, ","",.) if regexm(newp,"digital") & regexm(newp,"pincome")
replace newp=subinstr(newp,", call","",.) if regexm(newp,"call") & regexm(newp,"pincome")
replace newp=subinstr(newp,"call, ","",.) if regexm(newp,"call") & regexm(newp,"pincome")
replace newp=subinstr(newp,", pincome","",.) if regexm(newp,"altiplano")
replace newp=subinstr(newp,"pincome, ","",.) if regexm(newp,"altiplano")
}
***Spread
quietly{
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"difference")+regexm(description_`i',"spread")+regexm(description_`i',"outperformance")
replace sum2=regexm(description_`i',"performance")+regexm(description_`i',"rate")+regexm(description_`i',"level")+regexm(description_`i',"indices")+regexm(description_`i',"the two underlyings")+regexm(description_`i',"the two shares")+regexm(description_`i',"each of the shares")
replace sum3=regexm(description_`i',"between")+regexm(description_`i',"compared")+regexm(description_`i',"over")
replace sum4=regexm(description_`i',"minus")+regexm(description_`i',"plus")+regexm(description_`i',"increased")+regexm(description_`i',"decreased")+regexm(description_`i',"offers")+regexm(description_`i',"investors receive")+regexm(description_`i',"return is")+regexm(description_`i',"are calculated")
replace sum5=regexm(description_`i',"final level and the initial level")+regexm(description_`i',"the upper strike level and the lower strike level")+regexm(description_`i',"the strike level and the final level")
replace newp=newp+", spread" if sum1>=1&sum2>=1&sum3>=1&sum4>=1&sum5==0&newp!=""&regexm(newp,"spread")==0
replace newp="spread" if sum1>=1&sum2>=1&sum3>=1&sum4>=1&sum5==0&newp==""&regexm(newp,"spread")==1
} 
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"difference")
replace sum2=regexm(description_`i',"variable coupon")+regexm(description_`i',"is considered")
replace sum3=regexm(description_`i',"between")
replace sum4=regexm(description_`i',"swap rate")
replace newp=newp+", spread" if sum1>=1&sum2>=1&sum3>=1&sum4>=1&newp!=""&regexm(newp,"spread")==0
replace newp="spread" if sum1>=1&sum2>=1&sum3>=1&sum4>=1&newp==""&regexm(newp,"spread")==1
} 
replace newp=subinstr(newp,", spread","",.) if regexm(newp,"spread") & regexm(newp,"digital")
replace newp=subinstr(newp,"spread, ","",.) if regexm(newp,"spread") & regexm(newp,"digital")
replace newp=subinstr(newp,", floater","",.) if regexm(newp,"spread") & regexm(newp,"floater")
replace newp=subinstr(newp,"floater, ","",.) if regexm(newp,"spread") & regexm(newp,"floater")
replace newp=subinstr(newp,", call","",.) if regexm(newp,"call") & regexm(newp,"spread")
replace newp=subinstr(newp,"call, ","",.) if regexm(newp,"call") & regexm(newp,"spread")
replace newp=subinstr(newp,", pincome","",.) if regexm(newp,"spread")
replace newp=subinstr(newp,"pincome, ","",.) if regexm(newp,"spread")
}

***Bull Bear
quiet{
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"absolute")+regexm(description_`i',"paid out as a gain")
replace sum2=regexm(description_`i',"fall")+regexm(description_`i',"value")
replace newp="bullb" if sum1>=1&sum2>=1
} 

}





*******Variables
quiet{
gen primary=newp
gen call=regexm(payoff,"call")
gen call2=regexm(newp,"call")
la var call2 "Call"
gen floater=regexm(payoff,"floater")
gen floater2=regexm(newp,"floater")
la var floater2 "Floater"
gen pincome2=regexm(newp,"pincome")
la var pincome2 "Pure Income"
gen digital=regexm(payoff,"digital")
gen digital2=regexm(newp,"digital")
la var digital2 "Digital"
gen altiplano=regexm(payof,"altiplano")
gen altiplano2=regexm(newp,"altiplano")
la var altiplano2 "Altiplano"
gen spread=regexm(payoff,"spread")
gen spread2=regexm(newp,"spread")
la var spread2 "Spread"
gen bullear=regexm(payoff,"bullbear")
gen bullbear2=regexm(newp,"bullb")
la var bullbear2 "BullBear"
}

*******Errors
quiet{
forvalues i=1(1)17 {
replace sum1=regexm(description_`i',"full details of this product are available in the brochure below")
replace newp="Error" if sum1>=1
} 
drop if newp=="Error"
}

replace newp="call" if newp==""
