in_bits = [1 0 0 0 0 1 0 0 0 0 0 0 0 0];
bitrate = 1;
count_zero = 0;
bits = zeros(1,length(in_bits));
count_one = 0;
voltage = 1;

for i = 1:length(in_bits)
    if in_bits(i)==0
        bits(i)=0;
        count_zero = count_zero + 1;
    else
        bits(i)=1;
        count_one = count_one + 1;
        count_zero=0;
    end
    
    if count_zero==4 
        if mod(count_one,2)==1
            bits(i) = 'V';
        else
            bits(i-3) = 'B';
            bits(i) = 'V';
        end
        count_one = 0;
        count_zero = 0;
    end
end


T = length(bits)/bitrate;
n = 200;
N = n*length(bits);
dt = T/(N-1);
t = 0:dt:T;
signal = zeros(1,length(t));

%% AMI
pre_value = -1;

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
count = 0;

m = length(signal)/num_of_bits;

j = 1;

for k=1:m:length(signal)
    if signal(k)==0
        out_bits(j) = 0;
        count = count+1;
    else
        if signal(k)==same_value && count==2
            out_bits(j-3:j)=0;
            same_value = 0;
        elseif signal(k)==same_value && count==3
            out_bits(j)=0;
            same_value = 0;
        else
            out_bits(j) = 1;
            same_value = signal(k);
        end
        count = 0;
    end
    j++;
end

disp(out_bits);