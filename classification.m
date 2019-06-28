%% Classification
mean_fft_b = sum(abs(fft(beta_last_t)))/length(fft(beta_last_t));
mean_dft_b = sum(abs(goertzel(beta_last_t)))/length(goertzel(beta_last_t));
mean_t_b = sum(beta_last_t)/length(beta_last_t);
abs_b = sum(abs(beta_last_t))/length(beta_last_t);
mean_f_b = sum(beta_last_f)/length(beta_last_f);
abs_f_b = sum(abs(beta_last_f))/length(beta_last_f);

fft2b= abs(fft(beta_last_t));

mean_fft_a = sum(abs(fft(alpha_last_t)))/length(fft(alpha_last_t));
mean_dft_a = sum(abs(goertzel(alpha_last_t)))/length(goertzel(alpha_last_t));
mean_t_a = sum(alpha_last_t)/length(alpha_last_t);
abs_a = sum(abs(alpha_last_t))/length(alpha_last_t);
mean_f_a = sum(alpha_last_f)/length(alpha_last_f);
abs_f_a = sum(abs(alpha_last_f))/length(alpha_last_f);

fft2a= abs(fft(alpha_last_t));

abb= [abs_a.',abs_b.',mrk.y'];

abc = [windows(1,:,1).'];
data_classifier = [mrk.y',mean_fft_b.',mean_fft_a.',mean_dft_a.',mean_dft_b.',mean_t_b.', mean_t_a.',mean_f_a.',mean_f_b.',abs_b.',abs_a.'];


data_classifier_new = [mrk.y', fft2b(2,:).',fft2a(2,:).'];


data_classifier_newest = [alpha_last_f.', beta_last_f.', mrk.y'];