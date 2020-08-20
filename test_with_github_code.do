///////////////////////////////////////////////////////////////////////////////
// Clear memory

clear all

///////////////////////////////////////////////////////////////////////////////
// Remove packages folder 

!rm -r stata_packages
!rm -r development_stata_packages

///////////////////////////////////////////////////////////////////////////////
// Create packages folder 

!mkdir development_stata_packages 

///////////////////////////////////////////////////////////////////////////////
// Set package directories

cap adopath - PERSONAL
cap adopath - PLUS
cap adopath - SITE
cap adopath - OLDPLACE
adopath + "development_stata_packages"
net set ado "development_stata_packages"


///////////////////////////////////////////////////////////////////////////////
// Download ftools and reghdfe using GitHub instructions

* Install ftools (remove program if it existed previously)
cap ado uninstall ftools
net install ftools, from("https://raw.githubusercontent.com/sergiocorreia/ftools/master/src/")

* Install reghdfe 5.x
cap ado uninstall reghdfe
net install reghdfe, from("https://raw.githubusercontent.com/sergiocorreia/reghdfe/master/src/")

* Install boottest for Stata 11 and 12
if (c(version)<13) cap ado uninstall boottest
if (c(version)<13) ssc install boottest

* Install moremata (sometimes used by ftools but not needed for reghdfe)
cap ssc install moremata

ftools, compile
reghdfe, compile

// Test ftools
sysuse auto, clear 

fcollapse (sum) price (mean) gear, by(foreign)
list in 2 

// test reghdfe
sysuse auto, clear 

reghdfe price mpg, absorb(foreign) 


///////////////////////////////////////////////////////////////////////////////
// Download and test ivreghdfe
ssc install ivreg2
ssc install ranktest
net install ivreghdfe, from(https://raw.githubusercontent.com/sergiocorreia/ivreghdfe/master/src/)


sysuse auto, clear 

ivreghdfe price (gear = mpg), absorb(foreign) 
