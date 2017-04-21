function accuracy = activeLearningRamdomized(basepath, dataset,iterations)
    
    % Loading data mat files
    dataFiles = dir(strcat(basepath, '*', dataset, '.mat')); 
    for q = 1:length(dataFiles) 
        load(strcat(basepath, dataFiles(q).name)); 
    end
    
    num_classes = length(unique(trainingLabels));
    accuracy = zeros(iterations, 1);
    for itr = 1:iterations
        if itr ~= 1
            randomIndex = randi([1,length(unlabeledMatrix)],10,1);
            extractedUnLabeledMatrixRows = unlabeledMatrix(randomIndex, :);
            extractedUnLabeledLabelRows = unlabeledLabels(randomIndex, :);
            trainingMatrix = [trainingMatrix; extractedUnLabeledMatrixRows];
            trainingLabels = [trainingLabels; extractedUnLabeledLabelRows];
            unlabeledMatrix(randomIndex, :) = [];
            unlabeledLabels(randomIndex, :) = [];
        end
        
        % training Logistic Regression Classifier
        trainedWeights = train_LR_Classifier(trainingMatrix, trainingLabels, num_classes);
        testSamplesCount = length(testingMatrix);
        testResults = zeros(testSamplesCount, 1);
    
        % testing samples against the created model
        for i = 1:testSamplesCount
            testSample = testingMatrix(i, :);
            [maxProbability, class] = max(test_LR_Classifier(testSample, trainedWeights, num_classes));
            testResults(i, 1) = class;
        end
    
        % calculating accuracy
        comparisonMatrix = testResults == testingLabels;
        matches = sum(comparisonMatrix(:,:));
        accuracy(itr, 1) = matches/testSamplesCount * 100;
    end
end