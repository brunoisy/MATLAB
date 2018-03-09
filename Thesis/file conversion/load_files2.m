directory = 'data/text/LmrP Membrane';
destination = 'data/MAT/LmrP Membrane';
% 
% directory = 'data/text/LmrP Proteoliposomes';
% destination = 'data/MAT/LmrP Proteoliposomes';
apply_recursively(@load_file, directory, destination);
