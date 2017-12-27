in_bits = [1 0 0 0 0 0 0 0 0];
bitrate = 1;
count_zero = 0;
bits = zeros(1,length(in_bits));
voltage = 1;

%% Substitution
for i = 1:length(in_bits)
    if in_bits(i)==0
        bits(i)=0;
        count_zero = count_zero + 1;
    else
        bits(i)=1;
        count_zero=0;
    end
    if count_zero==8
        bits(i-4) = 'V';
        bits(i-3) = 'B';
        bits(i-1) = 'V';
        bits(i) = 'B';
        count_zero = 0;
    end
end

T = length(bits)/bitrate;
n = 200;
N = n*length(bits);
dt = T/(N-1);
t = 0:dt:T;
signal = zeros(1,length(t));

%% B8ZS
pre_value = -voltage;

for i = 0:length(bits)-1
    if bits(i+1)=='B'
        signal(i*n+1:(i+1)*n) = -pre_value;
        pre_value = -pre_value;
    elseif bits(i+1)=='V'
        signal(i*n+1:(i+1)*n) = pre_value;
    elseif bits(i+1) == 0
        signal(i*n+1:(i+1)*n) = 0;
    else
        signal(i*n+1:(i+1)*n) = -pre_value;
        pre_value = -pre_value;
    end
end

figure;
plot(t,signal,'LineWidth',3);
axis([0 t(end) -1.1 1.1])
grid on;

%% Demodulation
num_of_bits = T*bitrate;
out_bits = zeros(1,num_of_bits);
same_value = 0;
track_sig_pos = 0;
track_one_pos = 0;

m = length(signal)/num_of_bits;

j = 1;

for k=1:m:length(signal)
    if k == track_sig_pos + m
        continue;
    end
    if signal(k)==0
        out_bits(j) = 0;
    else
        if signal(k)==same_value && j==track_one_pos+2
            out_bits(j-3:j+1)=0;
            track_sig_pos = k;
            same_value = 0;
            j = j+2;
        else
            out_bits(j)=1;
            track_one_pos = j;
            same_value = signal(k);
        end
    end
    j++;
end

disp(out_bits);