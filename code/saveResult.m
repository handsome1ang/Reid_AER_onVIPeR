data_dir=('..\..\viper\');
files_a=dir([data_dir 'cam_a\' '*.bmp']);
files_b=dir([data_dir 'cam_b\' '*.bmp']);
files=[files_a;files_b];
fnames={files.name};
display('===============================================================');
display('selecting procedure :');
display(id_true_weak);
length(metrics);length(featname);
display('selected wLearners are : ')
display(learners);
display('which stand for: ');
for i=1:length(learners)
    sel_model{i}.name=[weakLearner{learners(i)}.featName '+' weakLearner{learners(i)}.metricName];
    sel_model{i}.weight=alpha_test(i);
    display([weakLearner{learners(i)}.featName '+' weakLearner{learners(i)}.metricName '  ' num2str(alpha_test(i))]);
end

display('===============================================================');

Toshow.result          = Result;
Toshow.lookupTable     = ref_ID;
Toshow.namelist_a      = {files_a.name};
Toshow.namelist_b      = {files_b.name};
Toshow.modellist       = sel_model;
Toshow.data_dir        = data_dir;
Toshow.rank            = rank; 
Toshow.alpha_test      = alpha_test;
save(['..\exp_results\results_' num2str(seed) '.mat'],'Toshow');