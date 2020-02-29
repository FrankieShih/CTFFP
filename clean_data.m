function [price_UAA_LM,price_UAA,price_LM,first_Date,last_Date,count_Date] = clean_data(filename)
%clean the data
%Input:
%   filename: file name of the data set
%Output:
%   price_UAA_LM: the whole data in file as a timeble
%   price_UAA: historical prices of UAA
%   price_LM: historical prices of LM
%   first_Date: the first date of the price
%   last_Date: the last date of the price
%   count_Date: th number of total record

% loading historical prices of UAA and LM
price_UAA_LM = readtimetable(filename);
price_UAA_LM.Date.Format = 'MM/dd/yyyy';
first_Date = price_UAA_LM.Date(1);
last_Date = price_UAA_LM.Date(end);
count_Date = length(price_UAA_LM.Date);

price_UAA = price_UAA_LM.UAA;
price_LM = price_UAA_LM.LM;

end

