set allProducts;
set months ordered;
set machines;

param nMachines{machines};
param time{machines, allProducts};
param profit{allProducts};
param maintenance{months, machines};
param demand{months, allProducts};

param storageCapacity;
param storageUnitCost;
param initStorage :=0;
param finalStorage;

set weeks;
set days;
param nShifts;
set shiftsAday = 1..nShifts;
param hoursAshift;

set shifts := {shiftsAday, days, weeks, months};
var production{allProducts, shifts} integer >=0;# quantity of each type of product produced during each shift
var storage{allProducts, months} integer >=0, <=storageCapacity;# quantity of each type of product in storage at end of month
var sales{a in allProducts, m in months} integer >=0, <=demand[m,a];# quantity of each type sold at each end of month



maximize profitTotal: sum{a in allProducts, m in months} profit[a]*sales[a,m] - storageUnitCost*sum{a in allProducts, m in months}storage[a,m];



subject to machineLimit{(sh,d,w,m) in shifts, ma in machines} :
			sum{a in allProducts} production[a,sh,d,w,m]*time[ma,a] <= (nMachines[ma]-maintenance[m,ma])*hoursAshift;

subject to firstMonthFlux{a in allProducts} : 
			sum{sh in shiftsAday, d in days, w in weeks} production[a,sh,d,w,first(months)]-sales[a,first(months)]==storage[a,first(months)];

subject to flux{a in allProducts, m in (months diff {first(months)})} : 
			sum{sh in shiftsAday, d in days, w in weeks} production[a,sh,d,w,m]-sales[a,m]==storage[a,m]-storage[a,prev(m, months)];

subject to finalStorageConstr{a in allProducts} : 
			storage[a,last(months)] == finalStorage;

			
			
			
# this variable is added only for easy display of monthly production			
var monthlyProd{allProducts, months} integer >= 0;

subject to prodSum{a in allProducts, m in months} :
			monthlyProd[a,m] == sum{sh in shiftsAday, d in days, w in weeks} production[a,sh,d,w,m];