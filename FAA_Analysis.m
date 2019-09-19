function PathDirectory = FAA_Analysis(selectpath, Start_Date, isLegend, Save_UP, FilePrefix,data,title1,Elim,Plot_All,Lines_Per_Plot,xSize,xdata)

%% Sort Paths
paths=strcat(num2str(data(:,2)),',',num2str(data(:,3)));
Unique_Paths=unique(paths,'rows');
npath=numel(Unique_Paths);
Unique_Paths=str2num(Unique_Paths);
paths=str2num(paths);
pathdata=[];
positions = (4:5:5*length(selectpath));
c=1;
%% Path elimination
try
for n = 1:length(Unique_Paths)
    for c=1:numel(Elim)
        if Unique_Paths(n,1) == Elim(c)
            Unique_Paths(n,2:3) = [0 0];
        elseif Unique_Paths(n,2) == Elim(c)
            Unique_Paths(n,2:3) = [0 0];
        end
    end
end
LogUP = Unique_Paths(:,2) ~= 0;
Unique_Paths = Unique_Paths(LogUP,:);
Unique_Paths(:,3) = [];
end
c=1;
col=1;
if Plot_All == 1
    positions = (4:5:5*length(Unique_Paths));
end
%% Generating Colors
colors = distinguishable_colors(Lines_Per_Plot,'w');
%% Plotting Logic
if Plot_All == 1
NumPaths = length(Unique_Paths);
NumGraphs = ceil(NumPaths/Lines_Per_Plot);
if rem(NumGraphs,2) == 0
    A = factor(NumGraphs);
    if NumGraphs ~= 2
    Rows = A(1); Columns = A(2);
    else
    Rows = 1; Columns = 2;
    end
else
     A = factor(NumGraphs-1);
     Rows = A(1)+1; Columns = A(2);
end
S = (1:length(Unique_Paths)/Lines_Per_Plot);
s=1;
subplot(Rows,Columns,S(1))
end
%% Plotting
if Plot_All == 1
    for n=1:length(Unique_Paths)
    logP= paths == Unique_Paths(n,:) ;
    logP=logical(logP(:,1).*logP(:,2));
    ndat = data(logP,:);
    if c== 18 & FilePrefix == 'OHP1_'
        ndat = ndat(1:62,:);
    end
    pathdata= [pathdata,ndat] ;
    Mfactor = pathdata(:,positions(c));
    for g=1:numel(Mfactor)
        if Mfactor(g) == 1000000
            Mfactor(g) = 0;
        end
    end
    pathdata(:,positions(c)) = Mfactor;
    [r,~]=size(pathdata);
    x=1:r;
  plot(x,pathdata(:,positions(c)),'LineWidth',2,'color',colors(col,:));
 % Finalizing Plots
 
    xlabel('Data Points');
    ylabel('Damage Indices');
    title(title1)
    axis([Start_Date r 0 1])
    
      if isLegend == 1
        rowS=size(pathdata);
        rowS=rowS(2)/5;
        pathPos = ((s-1)*50+2:5:5*rowS);
        pathsUsed = [];
        for f = 1:numel(pathPos)
            pathsUsed = [pathsUsed;pathdata(1,pathPos(f):pathPos(f)+1)];
        end
        pathsUsed=num2str(pathsUsed);
        legend(pathsUsed,'Location','best')
      end
 c=c+1;
    if mod(col,Lines_Per_Plot) == 0
     col =1;
     
       % Path labels

        s=s+1;
        if s<=NumGraphs
         %    xticks(xSize)
          %   xticklabels(num2cell(xdata))
           %  xtickangle(45)
     subplot(Rows,Columns,s)
    
        end
    else 
     col = col+1;
    end
 hold on
    end
    else
for n=selectpath
    logP= paths == Unique_Paths(n,:) ;
    logP=logical(logP(:,1).*logP(:,2));
    pathdata= [pathdata,data(logP,:)] ;
    Mfactor = pathdata(:,positions(c));
    for g=1:numel(Mfactor)
        if Mfactor(g) == 1000000
            Mfactor(g) = 0;
        end
    end
    pathdata(:,positions(c)) = Mfactor;
    [r,~]=size(pathdata);
    x=1:r;
plot(x,pathdata(:,positions(c)),'LineWidth',2,'color',colors(c,:));
 c=c+1;
 hold on
    % Finalizing Plots
    xlabel('Data Points');
    ylabel('Damage Indices');
    title(title1)
    axis([Start_Date r 0 1])
    % Path labels
    if isLegend == 1
        pathsUsed = Unique_Paths(selectpath,:);
        pathsUsed=num2str(pathsUsed);
        legend(pathsUsed,'Location','best')
    end
end
end

%% Seperate Path Data
if Plot_All == 1
    PathDirectory = 'No PathDirectory Generated';
else
table_Pos=(1:5:(c-1)*5);
PathDirectory=[];
c=1;
for n=1:numel(table_Pos)
PathDirectory=[PathDirectory,table(pathdata(:,table_Pos(n):table_Pos(n)+4))];
VarName = pathsUsed(c,:);
if isnan(str2double(VarName(1:2)))
   VarName(2)='_';
    VarName=erase(VarName,' ');
    VarName=['Path_',VarName];
else
     VarName(3)='_';
    VarName=erase(VarName,' ');
    VarName=['Path_',VarName];
end
PathDirectory.Properties.VariableNames(c) = {VarName};
c=c+1;
end
 Unique_Paths=[(1:length(Unique_Paths))',Unique_Paths];
if Save_UP == 1
    UP=table(Unique_Paths);
    FileName=[FilePrefix,'Unique_Paths.xlsx'];
    try
    writetable(UP,FileName,'Sheet',1);
    end
end
end
%% Cleaning
%vars = {'g','UP','table_Pos','Mfactor','logP','n','r','npath','numfile','hour1','minute1','second1','path','file','date1','month1','year1','positions','paths','data','c','x','selectpath','A','f','isLegend','dat'};
%clear(vars{:})
%clear vars

end
