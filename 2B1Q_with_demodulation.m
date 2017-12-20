in_bits = [0 1 1 0 1 1 0 0 1];
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

pre_level = voltage1;

for i = 0:2:length(bits)-2
  if bits(i+1) == 0
    if bits(i+2) == 0
      if pre_level>0
        x(i*n+1:(i+2)*n) = voltage1;
        pre_level = voltage1;
      else
        x(i*n+1:(i+2)*n) = -voltage1;
        pre_level = -voltage1;
      end
    else
      if pre_level>0
        x(i*n+1:(i+2)*n) = voltage2;
        pre_level = voltage2;
      else
        x(i*n+1:(i+2)*n) = -voltage2;
        pre_level = -voltage2;
      end
    end
  else
    if bits(i+2) == 0
      if pre_level>0
        x(i*n+1:(i+2)*n) = -voltage1;
        pre_level = -voltage1;
      else
        x(i*n+1:(i+2)*n) = voltage1;
        pre_level = voltage1;
      end
    else
      if pre_level>0
        x(i*n+1:(i+2)*n) = -voltage2;
        pre_level = -voltage2;
      else
        x(i*n+1:(i+2)*n) = voltage2;
        pre_level = voltage2;
      end
    end
  end
end


figure;
plot(t,x,'LineWidth',3);
axis([-1 t(end)+1 -3.1 3.1])
grid on;

%% Demodulation
disp(bits);
num_of_bits = T*bitrate;
out_bits = zeros(1,num_of_bits);

m = length(x)/num_of_bits;

j = num_of_bits;
disp(j);

for k=length(x)-2*m:-m*2:1
  if x(k+2*m)==voltage1
    if x(k)>0
      out_bits(j:j-1)=0;
    else
      out_bits(j)=0;
      out_bits(j-1)=1;
    end
  elseif x(k+2*m)==-voltage1
    if x(k)>0
      out_bits(j)=0;
      out_bits(j-1)=1;
    else
      out_bits(j:j-1)=0;
    end
  elseif x(k+2*m)==voltage2
    if x(k)>0
      out_bits(j)=1;
      out_bits(j-1)=0;
    else
      out_bits(j:j-1)=1;
    end
  else
    if x(k)>0
      out_bits(j:j-1)=1;
    else
      out_bits(j)=1;
      out_bits(j-1)=0;
    end
  end
  j = j - 2;
end

disp(out_bits);