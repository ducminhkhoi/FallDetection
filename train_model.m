function [ output_args ] = train_model( method, parameter, database, sheet_train, k )
%TRAIN_NEW_FEATURES Summary of this function goes here
%   Detailed explanation goes here

    [~, ~, train_files] = xlsread(database, sheet_train{1});
    all_train_videos = train_files(:,1);
    video_labels = train_files(:,2);
  
    time = train_files(:,3:4);
    temp_time = cell(size(time));
    time = [time temp_time];
    
    [~, ~, train_nonfall_files] = xlsread(database, sheet_train{2});
    all_train_nonfall_videos = train_nonfall_files(:,1);
    time_nonfall = train_nonfall_files(:,5:8);
    
    if strcmp(method, 'hmm')   
            
        state = 5;
        Seedrand = 1;    
        
        % train with fall   
        fall_videos = all_train_videos(strcmp(video_labels, 'Fall'));
        time_fall_videos = time(strcmp(video_labels, 'Fall'),:);
        [estTR, estO, estO_new, loglik] = HMM_training(k,state,Seedrand, fall_videos, time_fall_videos);

        save (['model/hmm/FallModel_state_' num2str(parameter) '.mat'], 'estTR', 'estO', 'estO_new', 'loglik')

        % train with nonfall
        non_fall_videos = all_train_videos(strcmp(video_labels, 'Norm'));
        non_fall_videos = [non_fall_videos; all_train_nonfall_videos];
        time_non_fall_videos = time(strcmp(video_labels, 'Norm'),:);
        time_non_fall_videos = [time_non_fall_videos; time_nonfall];
        [estTR, estO, estO_new, loglik] = HMM_training(k,state,Seedrand, non_fall_videos, time_non_fall_videos);

        save (['model/hmm/NonFallModel_state_' num2str(parameter) '.mat'], 'estTR', 'estO', 'estO_new', 'loglik')
        
    elseif strcmp(method, 'svm') % use parameter as window_size
        window_size = parameter;
        kernel_function = 'gaussian';
        all_train_videos = [all_train_videos; all_train_nonfall_videos];
        time = [time; time_nonfall];
        
        model = SVM_training(k,window_size,kernel_function,all_train_videos,time);
        
        file_save = ['model/svm/' kernel_function '_' num2str(window_size) '_train.mat'];
        save (file_save, 'model') ;
    end

end

