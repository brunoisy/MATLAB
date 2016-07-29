function [] = EtudeParamRendement()

p=linspace(160*100000,260*100000,6);
T=linspace(650,800,20);
Rendement=zeros(1,5);
for i=1:length(p)
    for j=1:length(T)
        Rendement(j)=GetRendement(T(j),p(i));
    end
    plot(T,Rendement);hold on;
end
end

