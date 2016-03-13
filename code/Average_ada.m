clear;
clc;
warning off;
tstart=clock;
%%
fold=10;
make_new_weak=1;
average =1;
%parpool local;
%iterations=36;
seedbase=20150720;      
%display(['when beta is ' num2str(rank_threshold) ', seed base is ' num2str(seedbase)]);
for round=1:fold
    seed = seedbase+round;
    rng(seed);
    loginfo=['v0.62_round' num2str(round)];
    %%
    Preset;
    if make_new_weak
        Buildweaklearners;
        save(['weLearners' loginfo '.mat'],'weakLearner');
    else
        load(['weLearnersv0.62_round' num2str(round) '.mat']);
    end;

%     rank_threshold=3;
    display([num2str(round) 'th round']);
    BoostWeakers;
    
end
save([resultDir 'v' num2str(seedbase) '.mat'],'rankfold');
%delete(gcp);
tstop=clock;
totaltime=etime(tstop,tstart);

figure; 
x=1:1:100;
y=mean(rankfold);
hold on;
grid on;
ylabel('Matching Rate(%)');
xlabel('Rank');
axis([1 50 0 100]);
title('Cumulative Matching Characteristic (CMC)');
plot(x,y);
% display(['when beta is ' num2str(rank_threshold)]);
% display(['rank1: ' num2str(y(1)) ' rank5: ' num2str(y(5)) ' rank10: ' num2str(y(10)) ' rank20: ' num2str(y(20))]);
display(['rank1: ' num2str(mean(rankfold(:,1))) ' rank5: ' num2str(mean(rankfold(:,5))) ' rank10: ' num2str(mean(rankfold(:,10))) ' rank20: ' num2str(mean(rankfold(:,20)))]);
display(['total time is ',num2str(totaltime),'s']);
% loginfo='v0.1';


