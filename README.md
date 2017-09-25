			   


			Readme File for Final Project - Fall Detection System
			        CS534 - Machine Learning
		----------------------------------------------------


There are three students in our group:
- Khoi Nguyen. Email: nguyenkh@oregonstate.edu
- Thi Tam Nguyen. Email: nguyeta4@oregonstate.edu
- Thi Kim Phung Lai. Email: laith@oregonstate.edu



Our code contains the following functions:
1. main.m: the main file that the program starts from
2. createCentroids.m: create clusters for training data
3. train_model.m: get list of train files and call specific HMM or SVM training function and save trained file for later use.
4. test_model.m: get list of test files and call specific HMM or SVM testing function and report the result
5. HMM_training.m: Set up variables for HMM training and train HMM
6. HMM_testing.m: load necessary files and compare posterior of fall and nonfall and give the final answer
7. SVM_training.m: Set up variables for SVM training and train SVM
8. SVM_testing.m: load necessary files and get predict. 
9. Other supported files.

Besides, we also have some folders:
1. model: contains model for clustering, hmm and svm
2. train_data: contains all .mat file extracted features from training data
3. test_data: contains all .mat file extacted features from testing data

Notice: we do not include any raw videos for small compression. For complete dataset, please visit: https://sites.google.com/site/falldetectionsystemdut/

-------------------
12/1/2015 - Final Release of the Code