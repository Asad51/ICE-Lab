in_bits = [0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1];
bitrate = 1;
count_zero = 0;
bits = zeros(1,length(in_bits));
prev = 1;

for i = 1:length(in_bits)
  if count_zero==8
    bits(i-5) = 'V';
    bits(i-4) = 'B';
    bits(i-2) = 'V';
    bits(i-1) = 'B';
    count_zero = 0;
  end
  if in_bits(i)==0
    bits(i)=0;
    count_zero = count_zero + 1;
  else
    bits(i)=1;
    count_zero=0;
  end
end

T = length(bits)/bitrate;
n = 200;
N = n*length(bits);
dt = T/(N-1);
t = 0:dt:T;
x = zeros(1,length(t));

%% AMI
pre_value = -1;

for i = 0:length(bits)-1
  if bits(i+1)=='B'
    x(i*n+1:(i+1)*n) = -pre_value;
    pre_value = -pre_value;
  elseif bits(i+1)=='V'
    x(i*n+1:(i+1)*n) = pre_value;
  elseif bits(i+1) == 0
    x(i*n+1:(i+1)*n) = 0;
  else
    x(i*n+1:(i+1)*n) = -pre_value;
    pre_value = (-1) * pre_value;
  end
end

figure;
plot(t,x,'LineWidth',3);
axis([0 t(end) -1.1 1.1])
grid on;

%% Demodulation
num_of_bits = T*bitrate;
out_bits = zeros(1,num_of_bits);
same_value = 0;
track = 0;
track_pos = 0;

m = length(x)/num_of_bits;

j = 1;

for k=1:m:length(x)
  if k == track + m
    continue;
  end
  if x(k)==0
    out_bits(j) = 0;
  else
    disp(x(k));
    if x(k)==same_value && j==track_pos+2
      out_bits(j-3:j+1)=0;
      track = k;
      same_value = 0;
      j = j+2;
    else
      out_bits(j)=1;
      track_pos = j;
      same_value = x(k);
    end
  end
  j++;
end

disp(out_bits);