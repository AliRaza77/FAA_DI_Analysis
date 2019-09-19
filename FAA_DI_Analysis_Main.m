%% Housecleaning
clear all, close all,  clc
%% Parameters
Frequencies = [200 250 300 350];  %Number of unique frequencies


Plot_All = 0;
Lines_Per_Plot = 10;
Elim = [];
selectpath = [55 56 57];   %Enter the Path serial number in the square brackets from
                              %the Unique_Paths variable to plot the targetted path.
                              %e.g selectpath = [1 2 3 4]; for all paths use selectpath = 1:36;
                              
Start_Date= 1;             %Enter the first data point which will be displayed in the final plot.
isLegend = 1;               %Enter 1 for plotting Legend, 0 for no Legend.
Save_UP=1;                 %Saves all the Unique Paths in the loaded files on an excel sheet.
AddCycles = 0;
%Enter the name of the file. **WARNING**, please include characters like '_' (underscore)
%until the first number in the filename
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
F200= [];
F250=[];
F300= [];
F350=[];
F400=[];
F450=[];
F500=[];


%%
for FreqNum = 1:numel(Frequencies);
    for inNum =1:numel(filename)
        intFile = char(filename(inNum));
        if intFile(24:26) == char(num2str(Frequencies(FreqNum)))
            if intFile(24:26) == char('200')
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
F200 = cellstr(F200);
F250 = cellstr(F250);
F300 = cellstr(F300);
F350 = cellstr(F350);
F400 = cellstr(F400);
F450 = cellstr(F450);
F500 = cellstr(F500);
end
%%
Reference = [F200,F250,F300,F350,F400,F450];
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