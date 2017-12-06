
bits = [0 0 1 1 0 1 1 0 0 1];
bitrate = 1; % bits per second



T = length(bits)/bitrate; % full time of bit sequence
n = 200;
N = n*length(bits);
dt = T/(N-1);
t = 0:dt:T;
x = zeros(1,length(t)); % output signal

%% 2B1Q

pre_level = 1;

for i = 0:2:length(bits)-1
  if bits(i+1) == 0
    if bits(i+2) == 0
      if pre_level>0
        x(i*n+1:(i+2)*n) = 1;
        pre_level = 1;
      else
        x(i*n+1:(i+2)*n) = -1;
        pre_level = -1;
      end
    else
      if pre_level>0
        x(i*n+1:(i+2)*n) = 3;
        pre_level = 3;
      else
        x(i*n+1:(i+2)*n) = -3;
        pre_level = -3;
      end
    end
  else
    if bits(i+2) == 0
      if pre_level>0
        x(i*n+1:(i+2)*n) = -1;
        pre_level = -1;
      else
        x(i*n+1:(i+2)*n) = 1;
        pre_level = 1;
      end
    else
      if pre_level>0
        x(i*n+1:(i+2)*n) = -3;
        pre_level = -3;
      else
        x(i*n+1:(i+2)*n) = 3;
        pre_level = 3;
      end
    end
  end
end


figure;
plot(t,x,'LineWidth',3);
axis([0 t(end) -3.1 3.1])
grid on;

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

%% MLT-3

pre_value = 0;
pre_value1 = -1;

for i = 0:length(bits)-1
  if bits(i+1) == 0
    x(i*n+1:(i+1)*n) = pre_value;
  else
    if pre_value == 0
      x(i*n+1:(i+1)*n) = (-1) * pre_value1;
      pre_value = (-1) * pre_value1;
    else
      x(i*n+1:(i+1)*n) = 0;
      pre_value1 = pre_value;
      pre_value = 0
    end
  end
end

figure;
plot(t,x,'LineWidth',3);
axis([0 t(end) -1.1 1.1])
grid on;