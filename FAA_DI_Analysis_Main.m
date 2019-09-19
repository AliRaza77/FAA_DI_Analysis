%% Housecleaning
clear all, close all,  clc
%% Parameters
Frequencies = [200];  %Number of unique frequencies

Plot_All = 1;
Elim = [];
selectpath = []; 
                
AddCycles = 0; %This feature does not work yet.

FilePrefix = 'ALP3_';
%% Import
[file,path]=uigetfile('Multiselect','on','*.dix');
numfile=numel(file);
data = [];
filename = cellstr(file)';
filename = [filename,num2cell(zeros(numfile,6))];
for f=1:numfile
    dat= cell2mat(filename(f));
    dat=erase(dat,FilePrefix);
    year1 = convertCharsToStrings(num2str(dat(7:8)));
    date1 = convertCharsToStrings(num2str(dat(4:5)));
    month1 = convertCharsToStrings(num2str(dat(1:2)));
    hour1 = convertCharsToStrings(num2str(dat(10:11)));
    minute1 = convertCharsToStrings(num2str(dat(13:14)));
    second1 = convertCharsToStrings(num2str(dat(16:17)));
    A = cellstr([month1 date1 year1 hour1 minute1 second1]);
    
filename(f,2:7) = A; 
end
title1 = num2str(dat(19:24));
filename= sortrows(filename,[4 1 2 5 6 7]);
filename(:,2:7) = [];
F100= [];
F150= [];
F200= [];
F250=[];
F300= [];
F350=[];
F400=[];
F450=[];
F500=[];
%% Hidden Paramters
Start_Date= 1; 
Lines_Per_Plot = 10;
isLegend = 1; 
Save_UP=1; 
%%
for FreqNum = 1:numel(Frequencies);
    for inNum =1:numel(filename)
        intFile = char(filename(inNum));
        if intFile(24:26) == char(num2str(Frequencies(FreqNum)))
            if intFile(24:26) == char('100')
                F100 = [F100;intFile];
            elseif intFile(24:26) == char('150')
                F150 = [F150;intFile];
            elseif intFile(24:26) == char('200')
                F200 = [F200;intFile];
            elseif intFile(24:26) == char('250')
                F250 = [F250;intFile];
            elseif intFile(24:26) == char('300')
                F300 = [F300;intFile];
            elseif intFile(24:26) == char('350')
                F350 = [F350;intFile];
            elseif intFile(24:26) == char('400')
                F400 = [F400;intFile];
            elseif intFile(24:26) == char('450')
                F450 = [F450;intFile];
            elseif intFile(24:26) == char('500')
                F500 = [F500;intFile];
            end
        end
    end
end
try
F150 = cellstr(F150);
end
try
F150 = cellstr(F150);
end
try
F200 = cellstr(F200);
end
try
F250 = cellstr(F250);
end
try
F300 = cellstr(F300);
end
try
F350 = cellstr(F350);
end
try
F400 = cellstr(F400);
end
try
F450 = cellstr(F450);
end
try
F500 = cellstr(F500);
end
%%
Reference = [F100,F150,F200,F250,F300,F350,F400,F450];
if AddCycles == 1;
XFilename = [FilePrefix 'SHM_directory.xlsx'];
[rowOfRef,~] = size(Reference);
xSize = (1:2:rowOfRef);
xdata = importdata(XFilename);
xdata = xdata.data;
xdata = xdata(1:2:end);
end
xSize = 1;
xdata = 1;
%% Import and Process

data = [];

try
 if iscell(F100)
  for n = 1:length(F100)
    data = [data',importdata(fullfile(path,F100{n}))']'; 
  end
else
  data = importdata(fullfile(path,F100));
end

   title1='100kHz';
PathDirectory100 = FAA_Analysis(selectpath, Start_Date, isLegend, Save_UP, FilePrefix,data,title1,Elim,Plot_All,Lines_Per_Plot,xSize,xdata);
if FreqNum>1
figure
end
end

try
 if iscell(F150)
  for n = 1:length(F150)
    data = [data',importdata(fullfile(path,F150{n}))']'; 
  end
else
  data = importdata(fullfile(path,F150));
end

   title1='150kHz';
PathDirectory200 = FAA_Analysis(selectpath, Start_Date, isLegend, Save_UP, FilePrefix,data,title1,Elim,Plot_All,Lines_Per_Plot,xSize,xdata);
if FreqNum>1
figure
end
end

try
 if iscell(F200)
  for n = 1:length(F200)
    data = [data',importdata(fullfile(path,F200{n}))']'; 
  end
else
  data = importdata(fullfile(path,F200));
end

   title1='200kHz';
PathDirectory200 = FAA_Analysis(selectpath, Start_Date, isLegend, Save_UP, FilePrefix,data,title1,Elim,Plot_All,Lines_Per_Plot,xSize,xdata);
if FreqNum>1
figure
end
end


try
data = [];
 if iscell(F250)
  for n = 1:length(F250)
    data = [data',importdata(fullfile(path,F250{n}))']'; 
  end
else
  data = importdata(fullfile(path,F250));
end

   title1='250kHz';
PathDirectory250 = FAA_Analysis(selectpath, Start_Date, isLegend, Save_UP, FilePrefix,data,title1,Elim,Plot_All,Lines_Per_Plot,xSize,xdata);
if FreqNum > 2
figure
end
end

try
data = [];
 if iscell(F300)
  for n = 1:length(F300)
    data = [data',importdata(fullfile(path,F300{n}))']'; 
  end
else
  data = importdata(fullfile(path,F300));
end
 
   title1='300kHz';
PathDirectory300 = FAA_Analysis(selectpath, Start_Date, isLegend, Save_UP, FilePrefix,data,title1,Elim,Plot_All,Lines_Per_Plot,xSize,xdata);
if FreqNum > 3
figure
end
end

try
data = [];
 if iscell(F350)
  for n = 1:length(F350)
    data = [data',importdata(fullfile(path,F350{n}))']'; 
  end
else
  data = importdata(fullfile(path,F350));
end
 
   title1='350kHz';
PathDirectory350 = FAA_Analysis(selectpath, Start_Date, isLegend, Save_UP, FilePrefix,data,title1,Elim,Plot_All,Lines_Per_Plot,xSize,xdata);
if FreqNum > 4
figure
end
end

try
data = [];
 if iscell(F400)
  for n = 1:length(F400)
    data = [data',importdata(fullfile(path,F400{n}))']'; 
  end
else
  data = importdata(fullfile(path,F400));
end
 
   title1='400kHz';
PathDirectory400 = FAA_Analysis(selectpath, Start_Date, isLegend, Save_UP, FilePrefix,data,title1,Elim,Plot_All,Lines_Per_Plot,xSize,xdata);
if FreqNum>5
figure
end
end

try
data = [];
 if iscell(F450)
  for n = 1:length(F450)
    data = [data',importdata(fullfile(path,F450{n}))']'; 
  end
else
  data = importdata(fullfile(path,F450));
end
 
   title1='450kHz';
PathDirectory450 = FAA_Analysis(selectpath, Start_Date, isLegend, Save_UP, FilePrefix,data,title1,Elim,Plot_All,Lines_Per_Plot,xSize,xdata);
if FreqNum > 6
figure
end
end

try
data = [];
 if iscell(F500)
  for n = 1:length(F500)
    data = [data',importdata(fullfile(path,F500{n}))']'; 
  end
else
  data = importdata(fullfile(path,F500));
end
 
   title1='500kHz';
PathDirectory500 = FAA_Analysis(selectpath, Start_Date, isLegend, Save_UP, FilePrefix,data,title1,Elim,Plot_All,Lines_Per_Plot,xSize,xdata);
end