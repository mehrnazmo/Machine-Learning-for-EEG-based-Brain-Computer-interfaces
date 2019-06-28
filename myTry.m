%% Correlation
load BCICIV_calib_ds1a.mat;
max_length = max(diff(mrk.pos));

% windows is a 3 dimensional matrix windows(i,j,k) shows kth channel, ith
% window, jth element of that window
windows = zeros(200,max_length,size(cnt,2));
windows_fft = windows;


for k = 1:size(cnt,2) 
    for i = 1:200
        if i>1
        windows(i,1:mrk.pos(i)-mrk.pos(i-1)+1,k)= cnt (mrk.pos(i-1):mrk.pos(i),k);
       
        else
            windows(i,1:mrk.pos(i),k)= cnt (1:mrk.pos(i),k);
            
        end
        
 
        end
end    

cl1=[]; 
cl2 = []; 
for i = 1:200  
     
        if mrk.y(i) ==1
        cl1 = [cl1,windows(i,:,1).'];
        else
        cl2 = [cl2,windows(i,:,1).'];  
        end  
end


 
classNum1 = [];
classNum2 = [];
%{ 
for i = 1:200  
     for k = 1:size(cnt,2)
        if mrk.y(i) ==1
        classNum1 = [classNum1,windows(i,:,k).'];
        else
        classNum2 = [classNum2,windows(i,:,k).'];  
        
        end
     end
 end

%}
windows_prime = permute(windows,[2 1 3]);

windows_fft = abs(fft(windows_prime));   

    



%Channel 1
window1 = windows(1,:,1).';
window2 = windows(2,:,1).';
window3 = windows(3,:,1).';
window4 = windows(4,:,1).';
window5 = windows(5,:,1).';
window1_fft = windows_fft(1,:,1).';
window2_fft = windows_fft(2,:,1).';

%{
r = zeros (200);
for i = 1:200
    for j = 1:200
        r(i,j) = max(xcorr(windows_fft(1,:,1),windows_fft(2,:,1)));
    end
end

w=r(:);
r1 = maxk(w,400);
most_correlated = [];
for i = 1:length(r1)
most_correlated = [most_correlated;find(r==r1(i))];
end

%finding most_correlated windows
row = ceil (most_correlated(:)/200);
column = most_correlated(:) - 200*(row(:)-1);

%finding same class
same_class = [];
for i = 1 : length(column)
    if row(i)~=column(i)
        same_class = [same_class;[row(i),column(i)]];
    end
end
class1 = same_class(1,:)';
for i = 1:length(same_class)
    if (ismember(same_class(i,1),class1(:)))
        if ~(ismember(same_class(i,2),class1(:)))
            class1 = [class1;same_class(i,2)];
        end
    elseif ismember(same_class(i,2),class1(:))
        if ~(ismember(same_class(i,1),class1(:)))
        class1 = [class1;same_class(i,1)];
        end
    end
end

a = mrk.y(class1(:));

%}

Fs = 100;
N = length(cnt(:,1));
xdft = fft(cnt(:,1));
xdft = xdft(1:N/2+1);
psdx = (1/(Fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:Fs/length(cnt(:,1)):Fs/2;

plot(freq,10*log10(psdx))
grid on
title('Periodogram Using FFT')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (dB/Hz)')