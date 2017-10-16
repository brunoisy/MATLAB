set allProducts;
set nutriments;

param valNutr{allProducts, nutriments};
param prix{allProducts};
param lowerBound{nutriments};
param upperBound{nutriments};

var products{allProducts} integer >=0; 

minimize cost: sum{a in allProducts} prix[a]*products[a];

subject to lowerBounds{n in nutriments} : sum{a in allProducts} valNutr[a,n]*products[a] >= lowerBound[n];
subject to upperBounds{n in nutriments} : sum{a in allProducts} valNutr[a,n]*products[a] <= upperBound[n];
