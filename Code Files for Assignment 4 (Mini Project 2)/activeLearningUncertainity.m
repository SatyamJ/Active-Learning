function accuracy = activeLearningUncertainity(basepath, dataset, iterations)
    % Loading data mat files
    dataFiles = dir(strcat(basepath, '*', dataset, '.mat')); 
    for q = 1:length(dataFiles) 
        load(strcat(basepath, dataFiles(q).name)); 
    end
    
    num_classes = length(unique(trainingLabels));
    accuracy = zeros(iterations, 1);
    
    
    for itr = 1:iterations
        % training Logistic Regression Classifier
        trainedWeights = train_LR_Classifier(trainingMatrix, trainingLabels, num_classes);
        testSamplesCount = length(testingMatrix);
        testResults = zeros(testSamplesCount, 1);
        
        if itr ~= 1
            unlabeledSamplesCount = length(unlabeledLabels);
            entropyValues = zeros(unlabeledSamplesCount, 1);
            
            for j=1:unlabeledSamplesCount
                unlabeledSample = unlabeledMatrix(j,:);
                probability = test_LR_Classifier(unlabeledSample, trainedWeights, num_classes);
                
                
                logOfProb = log2(probability);
                mul = probability.*logOfProb;
                entropyValues(j, 1) =  - sum(mul);
            end
            
            [sortedEntropy,sortingIndices] = sort(entropyValues,'descend');
            maxEntropyIndices = sortingIndices(1:10);
            extractedUnLabeledMatrixRows = unlabeledMatrix(maxEntropyIndices, :);
            extractedUnLabeledLabelRows = unlabeledLabels(maxEntropyIndices, :);
            trainingMatrix = [trainingMatrix; extractedUnLabeledMatrixRows];
            trainingLabels = [trainingLabels; extractedUnLabeledLabelRows];
            unlabeledMatrix(maxEntropyIndices, :) = [];
            unlabeledLabels(maxEntropyIndices, :) = [];
        end
       
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