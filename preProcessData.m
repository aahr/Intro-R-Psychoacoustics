% Introduction to R for Psychoacoustics
% Axel Ahrens, aahr@dtu.dk


%% read data
load('data.mat') %SRT, subjNames, conditionNames

%% pre-process data
% make the data tidy (see introduction to Tidyverse, https://www.tidyverse.org/)
SRTmatrix = reshape(SRT, [], 1);
SRTArray = num2cell(SRTmatrix);
subjNameArray = repmat(subjNames, [length(conditionNames)*length(listenerType),1]);
conditionNameArray = reshape(repmat(conditionNames', [length(subjNames),length(listenerType)]),[],1);
listenerTypeArray = reshape(repmat(listenerType,[length(subjNames)*length(conditionNames),1]),[],1);

%% export data as csv
header = {'Subject','Condition','ListenerType','SRT'};
dataArray = [subjNameArray,conditionNameArray,listenerTypeArray,SRTArray];
% Convert cell to a table and use first row as variable names
T = cell2table(dataArray,'VariableNames',header);
% Write the table to a CSV file
writetable(T,'dataForR.csv')
