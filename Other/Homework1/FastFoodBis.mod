set allProducts;
set burgers;
set frites;
set salades;
set boissons;
set nutriments;

param valNutr{allProducts, nutriments};
param prix{allProducts};
param lowerBound{nutriments};
param upperBound{nutriments};

var products{allProducts} integer >=0; 

minimize cost: sum{a in allProducts} prix[a]*products[a];

subject to lowerBounds{n in nutriments} : sum{a in allProducts} valNutr[a,n]*products[a] >= 0.8*lowerBound[n];
subject to upperBounds{n in nutriments} : sum{a in allProducts} valNutr[a,n]*products[a] <= 1.2*upperBound[n];
subject to maxProduct{a in allProducts} : products[a] <= 2;
subject to MinBurgers : sum{b in burgers} products[b] >= 1;
subject to MinBoissons : sum{b in boissons} products[b] >= 1;
subject to MinFrites: sum{f in frites} products[f] >= 1;
subject to MinSalades : sum{s in salades} products[s] >= 1;

