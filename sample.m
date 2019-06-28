%% Finding mu and beta bands
beta_max = zeros(200);
alpha_max = zeros(200);
f1=figure;
f2=figure;

beta_last_t = [];
alpha_last_t = [];
beta_last_f = [];
alpha_last_f = [];
for i = 1:200
s=windows(i,:,1).';

%s = cl1(:,i);
%s = cnt(:,1);
%figure;p=plot(s);
%title('EEG Signal')
% Sampling frequency
fs = 100;
N=length(s); 
figure(f1);

waveletFunction = 'db8';
                [C,L] = wavedec(s,8,waveletFunction);

                cD6 = detcoef(C,L,6); %BETA
                cD7 = detcoef(C,L,7); %ALPHA
         
                D6 = wrcoef('d',C,L,waveletFunction,6); %BETA
                D7 = wrcoef('d',C,L,waveletFunction,7); %ALPHA
                
                Beta = D6;
                beta_last_t = [beta_last_t,Beta];
                %figure;
                subplot(2,1,1); plot(1:1:length(Beta), Beta); title('BETA');hold on;
                
                
                Alpha = D7;
                alpha_last_t = [alpha_last_t,Alpha];
                subplot(2,1,2); plot(1:1:length(Alpha),Alpha); title('ALPHA'); hold on;

                
               
figure(f2);              
D6 = detrend(D6,0);
xdft2 = fft(D6);
freq2 = 0:N/length(D6):N/2;
xdft2 = xdft2(1:length(D6)/2+1);
beta_last_f = [beta_last_f,abs(xdft2)];

subplot(211);plot(freq2,abs(xdft2));title('BETA');hold on;
[~,I] = max(abs(xdft2));
beta_max(i) = freq2(I);

D7 = detrend(D7,0);
xdft3 = fft(D7);
freq3 = 0:N/length(D7):N/2;
xdft3 = xdft3(1:length(D7)/2+1);
alpha_last_f = [alpha_last_f,abs(xdft3)];

subplot(212);plot(freq3,abs(xdft3));title('ALPHA');
[~,I] = max(abs(xdft3));
alpha_max(i) = freq3(I);


              
end


