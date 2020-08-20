///////////////////////////////////////////////////////////////////////////////
// Clear memory

clear all

///////////////////////////////////////////////////////////////////////////////
// Remove packages folder 

!rm -r stata_packages
!rm -r development_stata_packages

///////////////////////////////////////////////////////////////////////////////
// Create packages folder 

!mkdir stata_packages 

///////////////////////////////////////////////////////////////////////////////
// Set package directories

cap adopath - PERSONAL
cap adopath - PLUS
cap adopath - SITE
cap adopath - OLDPLACE
adopath + "stata_packages"
net set ado "stata_packages"


///////////////////////////////////////////////////////////////////////////////
// Download and test ftools
ssc install moremata
ssc install ftools 


sysuse auto, clear 

fcollapse (sum) price (mean) gear, by(foreign)
list in 2 

///////////////////////////////////////////////////////////////////////////////
// Download and test reghdfe
ssc install reghdfe 


sysuse auto, clear 

reghdfe price mpg, absorb(foreign) 


///////////////////////////////////////////////////////////////////////////////
// Download and test ivreghdfe
ssc install ivreg2
ssc install ranktest
ssc install ivreghdfe 


sysuse auto, clear 

ivreghdfe price (gear = mpg), absorb(foreign) 

/*
Fails:
(existing lftools.mlib compiled with Stata ???; need to recompile for Stata 15.1)
(compiling lftools.mlib for Stata 15.1)
file "lftools.mlib" not found
*/
