function run(iterations)
    tic
    averageRandom = zeros(iterations, 1);
    averageUncertainity = zeros(iterations, 1);
    
    basepath1 = '../Data for Assignment 4 (Mini Project 2)/Active Learning/MindReading/';
    for i = 1:3
        randomSamplingAccuracy = activeLearningRamdomized(basepath1, num2str(i),iterations);
        averageRandom = averageRandom + randomSamplingAccuracy;
        uncertainitySamplingAccuracy = activeLearningUncertainity(basepath1, num2str(i), iterations);
        averageUncertainity = averageUncertainity + uncertainitySamplingAccuracy;
    end
    
    averageRandom = averageRandom/3;
    averageUncertainity = averageUncertainity/3;
    x = 1:50;
    figure;
    subplot(2,1,1);
    plot(x, averageRandom(x,1), x, averageUncertainity(x,1));
    title('MindReading Dataset');
    xlabel('iterations');
    ylabel('accuracy');
    
    averageRandom = zeros(iterations, 1);
    averageUncertainity = zeros(iterations, 1);
    basepath2 = '../Data for Assignment 4 (Mini Project 2)/Active Learning/MMI/';
    for i = 1:3
        randomSamplingAccuracy = activeLearningRamdomized(basepath2, num2str(i),iterations);
        averageRandom = averageRandom + randomSamplingAccuracy;
        uncertainitySamplingAccuracy = activeLearningUncertainity(basepath2, num2str(i), iterations);
        averageUncertainity = averageUncertainity + uncertainitySamplingAccuracy;
    end
    
    averageRandom = averageRandom/3;
    averageUncertainity = averageUncertainity/3;
    x = 1:50;
    subplot(2,1,2);
    plot(x, averageRandom(x,1), x, averageUncertainity(x,1));
    title('MMI');
    xlabel('iterations');
    ylabel('accuracy');
    toc
end