txt_dir    = 'MATLAB codes/FD curves/txt';
raw_dir    = 'MATLAB codes/FD curves/raw';
clean_dir  = 'MATLAB codes/FD curves/clean';
fitted_dir = 'MATLAB codes/FD curves/fitted';

raw_plots_dir        = 'MATLAB codes/plots/raw';
clean_plots_dir      = 'MATLAB codes/plots/clean';
fitted_plots_dir     = 'MATLAB codes/plots/fitted';





load_files(txt_dir, raw_dir,true);

preprocess_FD_curves(raw_dir, clean_dir);

fit_FD_curves(clean_dir, fitted_dir);



plot_FD_curves(raw_dir, raw_plots_dir);% add limits in param
% plot_FD_curves(clean_dir, clean_plots_dir);
% plot_FD_curves(fitted_dir, fitted_plots_dir);