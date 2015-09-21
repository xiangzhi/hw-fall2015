 
% Does computation of the filter bank and dictionary, and saves
% it in dictionary.mat 


load('../dat/traintest.mat'); 
test_list = {'airport/sun_aerinlrdodkqnypz.jpg','airport/sun_aerprlffjscovbbc.jpg','airport/sun_aesovualhburmfhn.jpg'};
[filterBank,dictionary] = getFilterBankAndDictionary(strcat(['../dat/'],train_imagenames));
%[filterBank,dictionary] = getFilterBankAndDictionary(strcat(['../dat/'],test_list));
save('dictionary.mat','filterBank','dictionary'); 