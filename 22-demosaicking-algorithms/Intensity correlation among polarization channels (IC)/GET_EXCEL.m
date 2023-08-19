%% Describe:
% This code can get more than one scenarios' demosaicing evaluation indexes 
%   with the specific algorithm discussed in this folder at one time. 
% 
%% Note:
% Make sure to put this code and the 'RGB_images' folder in the same folder.
%
%% Input:
% 30 scenarios, each one contains 4 RGB polarization images.
%
%% Output:
% A 'results' excel: 
%   each row represents a scenario.
%   each column represents one evaluation index, from left to right:
%   I0, I45, I90, I135, S0, S1, S2, DOLP, AOLP and t
%   (9 polarization-parameters' PSNRs and the running time).


%% PRE
clc
close all;
clear all;
% add images folder
addpath('RGB_images'); 


%% read 30 scenarios, calculate every one's 10 evaluation indexes and record them
% row: number of scenarios, column: number of evaluation indexes
r=30; 
c=10; 
% record all scenarios' indexes in one matrix 'RESULT'
RESULT=zeros(r,c);
% read 30 scenarios, 120 pics in total 
for i=1:30 
    a=4*(i-1)+1;
    b=a+1;
    c=b+1;
    d=c+1;
    a=strcat('RGB_images\',num2str(a),'.png');
    b=strcat('RGB_images\',num2str(b),'.png');
    c=strcat('RGB_images\',num2str(c),'.png');
    d=strcat('RGB_images\',num2str(d),'.png');
    I0=double(imread(a));
    I45=double(imread(b));
    I90=double(imread(c));
    I135=double(imread(d));
    % get indexes using the 'run_database' function and then record them
    result=run_database(I0,I45,I90,I135);
    RESULT(i,:)=result;
end


%% write down the results (create an excel)
xlswrite('results.xlsx',RESULT);
