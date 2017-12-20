in_bits = [1 1 0 0 0 1 1 1 1 0];
bitrate = 1; % bits per second
voltage1 = 1;
voltage2 = 3;

bits = zeros(1,length(in_bits));

if mod(length(in_bits),2)==1
  bits = zeros(1,length(in_bits)+1);
  for j=length(in_bits):-1:1
    bits(j+1) = in_bits(j);
  end
  bits(1) = 0;
  disp(length(in_bits));
else
  for j=1:length(bits)
    bits(j) = in_bits(j);
  end
end



T = length(bits)/bitrate; % full time of bit sequence
n = 200;
N = n*length(bits);
dt = T/(N-1);
t = 0:dt:T;
x = zeros(1,length(t)); % output signal

%% 2B1Q



for i = 0:2:length(bits)-2
  if bits(i+1) == 0
    if bits(i+2) == 0
      x(i*n+1:(i+2)*n) = -voltage2;
    else
      x(i*n+1:(i+2)*n) = -voltage1;
    end
  else
    if bits(i+2) == 0
      x(i*n+1:(i+2)*n) = voltage2;
    else
      x(i*n+1:(i+2)*n) = voltage1;
    end
  end
end


figure;
plot(t,x,'LineWidth',3);
axis([-1 t(end)+1 -3.1 3.1])
grid on;


%%demodulation
num_of_bits = T*bitrate;
out_bits = zeros(1,num_of_bits);

m = length(x)/num_of_bits;

j = 1;

for k=1:2*m:length(x)
  if x(k)==voltage1
    out_bits(j:j+1)=1;
  elseif x(k)==-voltage1
    out_bits(j)=0;
    out_bits(j+1)=1;
  elseif x(k)==voltage2
    out_bits(j)=1;
    out_bits(j+1)=0;
  else
    out_bits(j:j+1)=0;
  end
  disp(x(k));
  j = j + 2;
end

disp(out_bits);