addpath('helpers')

goodfiles = dir('curves_LmrP_proteoliposomes/good');
goodfiles = goodfiles([goodfiles.isdir]==false);

badfiles = dir('curves_LmrP_proteoliposomes/bad');
badfiles = badfiles([badfiles.isdir]==false);

filenames = {goodfiles(:).name};
for i = 1:length(filenames)
    comma2point_overwrite(strcat('curves_LmrP_proteoliposomes/good/',filenames{i}))% change commas to points
end

filenames = {badfiles(:).name};
for i = 1:length(filenames)
    comma2point_overwrite(strcat('curves_LmrP_proteoliposomes/bad/',filenames{i}))% change commas to points
end
