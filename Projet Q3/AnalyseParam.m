function [] = AnalyseParam()
% ANALYSE PARAMETRIQUE

% pour une 1500 tonnes d'ammoniac, combien de tonnes de CH4 aura-t'on
% besoin en fonction de la temperature?

temp=[500 550 600 650 700 750 800 850 900 950 1000 1050];
mCH4tot=zeros(1,12);
for i=1:12
    mCH4tot(i)=AmmoniacFactoryForAnalyseParam(1500,temp(i));
end

plot(temp,mCH4tot)

end

