function tester()
    load('dictionary.mat','filterBank','dictionary');
    img = imread('../dat/airport/sun_afcdhvryylnbwimp.jpg');
    D = getVisualWords(img, filterBank,dictionary);
end