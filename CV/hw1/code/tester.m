function tester()
    bank = createFilterBank();
    img = imread('../dat/test.jpg');
    extractFilterResponses(img, bank);
end