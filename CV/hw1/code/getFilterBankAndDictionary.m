function [filterBank, dictionary] = getFilterBankAndDictionary(image_names)

%constant
K = 300;
F = 9; %filter bank size?
alpha = 150;

%first create the filterBank
filterBank = createFilterBank();
% create the matrix that is going to hold the reponse
filterResponses = zeros(alpha * length(image_names), length(filterBank) * 3);

%loop through all the images
for i=1:length(image_names)
    disp(image_names{i});
    image = imread(image_names{i});
    %apply the filterbank on the image
    response = extractFilterResponses(image, filterBank);
    %get a random number of the response;
    filterResponses(((i-1)*alpha+1):i*alpha,:)= response(randperm(size(response,1),alpha), :);
end
%generate the kmeans
[~, dictionary] = kmeans(filterResponses, K, 'EmptyAction','drop');
%transpose it
dictionary = dictionary';

