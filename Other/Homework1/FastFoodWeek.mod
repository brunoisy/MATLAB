set days ordered;
set allProducts ordered;
set burgers;
set frites;
set salades;
set boissons;
set nutriments;

param valNutr{allProducts, nutriments};
param prix{allProducts};
param lowerBound{nutriments};
param upperBound{nutriments};

var products{allProducts, days} integer >=0; # quantity of each product chosen for the menu for each day

minimize cost: sum{a in allProducts, d in days} prix[a]*products[a, d];

subject to lowerBounds{n in nutriments, d in days} : sum{a in allProducts} valNutr[a,n]*products[a,d] >= 0.5*lowerBound[n];
subject to upperBounds{n in nutriments, d in days} : sum{a in allProducts} valNutr[a,n]*products[a,d] <= 1.4*upperBound[n];
subject to variety{a in allProducts}: sum{d in days} products[a,d] <= 2;
subject to MinBurgers{d in days}: sum{b in burgers} products[b,d] >= 1;
subject to MinBoissons{d in days}: sum{b in boissons} products[b,d] >= 1;
subject to MinFrites{d in days}: sum{f in frites} products[f,d] >= 1;
subject to MinSalades{d in days}: sum{s in salades} products[s,d] >= 1 ;



