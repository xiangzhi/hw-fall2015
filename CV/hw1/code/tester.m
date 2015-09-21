function tester()

    load('dictionary.mat','filterBank','dictionary');
    img = imread('../dat/bedroom/sun_aacyfyrluprisdrx.jpg');
    getVisualWords(img, filterBank,dictionary);
    %load('../dat/airport/sun_afcdhvryylnbwimp.mat');
    %disp(size(wordMap));
    %h = getImageFeatures(wordMap,300);
    %h = getImageFeaturesSPM(2, wordMap, 300);
    %disp(size(h));
    %
    %A = [ 1 6 1;1 3 1;2 9 7];
    %C = [5;1;3];
    %distanceToSet(C,A);
end