txt_directory = 'MATLAB codes/FD curves/FD curves txt';
raw_mat_directory = 'MATLAB codes/FD curves/FD curves mat raw';
clean_mat_directory = 'MATLAB codes/FD curves/FD curves mat clean';


load_files(txt_directory, raw_mat_directory,true)

preprocess_FD_curves(raw_mat_directory, clean_mat_directory)