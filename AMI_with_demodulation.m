bits = [1 1 0 1 1 0 0 1];
bitrate = 2; % bits per second

T = length(bits)/bitrate; % full time of bit sequence
n = 200;
N = n*length(bits);
dt = T/(N-1);
t = 0:dt:T;
x = zeros(1,length(t)); % output signal

%% AMI
pre_value = 1;

for i = 0:length(bits)-1
  if bits(i+1) == 0
    x(i*n+1:(i+1)*n) = 0;
  else
    x(i*n+1:(i+1)*n) = pre_value;
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

m = length(x)/num_of_bits;

j = 1;

for k=1:m:length(x)
  if x(k)==0
    out_bits(j) = 0;
  else
    out_bits(j) = 1;
  end
  j++;
end

disp(out_bits);






