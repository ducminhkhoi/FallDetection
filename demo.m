
video_name = 'si0204F.mat'; % fall video
% video_name = 'cr0410N.mat'; % non fall video

if strcmp(method, 'hmm')
    [classify, output] = HMM_testing(k, parameter, video_name);
elseif strcmp(method, 'svm')
    kernel_function = 'gaussian';
    [classify, output] = SVM_testing(k, video_name, kernel_function, parameter);
end

if classify == 1
    result = 'Fall Video'
else
    result = 'Non Fall Video'
end
    



