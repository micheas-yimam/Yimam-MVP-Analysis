clear all;
close all;

load baseballdata.mat
load Projection.mat

rawData=BaseballDataFinalS1; 
NationLeague = table2array(rawData(1:909,[1,3:14]));
AmericLeague = table2array(rawData(910:end,[1,3:14]));

%Number of Data Entries
vaN= 1:159 ;
vaA= 1:171 ;
trN= 160:909 ;
trA= 172:870 ;

glm_pred =@(A_in,B_in,A_pred) glmval(glmfit(A_in,B_in,'normal'),A_pred,'identity');
%%American League
% Linear Model with Sabermetric Stats
sN= glm_pred(NationLeague(trN,[2,3]),NationLeague(trN,13),NationLeague(vaN,[2,3]));
MSE(1,1)= mean((sN-NationLeague(vaN,13)).^2);

% Linear Model with Individual Stats
iN= glm_pred(NationLeague(trN,[4:12]),NationLeague(trN,13),NationLeague(vaN,[4:12]));
MSE(2,1)= mean((iN-NationLeague(vaN,13)).^2);

%%National League
% Linear Model with Sabermetric Stats
sA= glm_pred(AmericLeague(trA,[2,3]),AmericLeague(trA,13),AmericLeague(vaA,[2,3]));
MSE(1,2)= mean((sA-AmericLeague(vaA,13)).^2);

% Linear Model with Individual Stats
iA= glm_pred(AmericLeague(trA,[4:12]),AmericLeague(trA,13),AmericLeague(vaA,[4:12]));
MSE(2,2)= mean((iA-AmericLeague(vaA,13)).^2);

% Stepwise Model
%    M = stepwiseglm(AmericLeague(:,2:12),AmericLeague(:,13),'Linear','PEnter',0.05 ,'PRemove',0.1);
% M1 = stepwiseglm(NationLeague(:,2:12),NationLeague(:,13),'Linear','PEnter',0.05 ,'PRemove',0.1);

% fAL= glm_pred(AmericLeague(trA,[2:3,5:8,10:11]),AmericLeague(trA,13),AmericLeague(vaA,[2:3,5:8,10:11]));
% fNL= glm_pred(NationLeague(trN,[2:3,5,7:10,12]),NationLeague(trN,13),NationLeague(vaN,[2:3,5,7:10,12]));

%% Boxplot
% boxplot(table2array(rawData(:,14)))
% xlabel('Complete Dataset')
% ylabel('MVP Votes')
% title('Distribution of MVP Votes')

%% Projection Model
 NLeague = table2array(Projection(1:30,[28,6,7,12,16,17,14]));
ALeague = table2array(Projection(31:50,[28,6,11,7,12,17,13]));

% NLeague= 2:32;
%  ALeague= 33:51;
% 
   pAL= glm_pred(AmericLeague(:,[3,5:8,10:11]),AmericLeague(:,13),ALeague(:,:));
  pNL= glm_pred(NationLeague(:,[3,5,7:10,12]),NationLeague(:,13),NLeague(:,:));


%% Draft Analysis 
ADLeague = table2array(Projection(
NDLeague = table2array(

pDAL = glm_pred(AmericLeague(:,[3,5:8,10:11]),AmericLeague(:,13),ADLeague(:,:));
pDNL = glm_pred(NationLeague(:,[3,5,7:10,12]),NationLeague(:,13),NDLeague(:,:));

