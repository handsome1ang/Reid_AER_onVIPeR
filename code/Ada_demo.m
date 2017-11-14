clear;
clc;
warning off;
tstart=clock;
%% some parameter settings
seed = 20150721;
rng(seed);
loginfo='v0.62_round3';
make_new_weak=1;
round=1;


%%
%configuration of this experiment
Preset;
if make_new_weak
    Buildweaklearners;
    save(['weLearners' loginfo '.mat'],'weakLearner');
else
    load(['weLearners' loginfo '.mat']);
end;


BoostWeakers;
tstop=clock;
totaltime=etime(tstop,tstart);

%% Result show
saveResult;
figure; 
x=1:1:100;
y=rank;
hold on;
grid on;
ylabel('Matching Rate(%)');
xlabel('Rank');
axis([1 50 0 100]);
title('Cumulative Matching Characteristic (CMC)');
plot(x,y);
display(['rank1: ' num2str(mean(rankfold(:,1))) ' rank5: ' num2str(mean(rankfold(:,5))) ' rank10: ' num2str(mean(rankfold(:,10))) ' rank20: ' num2str(mean(rankfold(:,20)))]);
display(['total time is ',num2str(totaltime),'s']);
% loginfo='v0.1';

save([resultDir loginfo '.mat'],'rank');
