clc;
clear all;
close all;

am = 1;      %Amplitude

%% Message Signal
x = [1 1 0 1 1 0 0 1];
bitrate = 1; % bits per second

T = length(x)/bitrate; % full time of bit sequence
n = 100;
N = n*length(x);
dt = T/N;
t = 0:dt:T;
ms = zeros(1,length(t)); % message signal                                           

%genearating signal
for j=0:1:length(x)-1
    if x(j+1) == 0
       ms(j*n+1:(j+1)*n)=0;
    else
       ms(j*n+1:(j+1)*n)=am;
    end
end
subplot(4,1,1);
plot(t,ms,'lineWidth',2.5);
grid on;
%axis([ 0 t(end)+1 -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Message Signal');

%% Carrier Signal

f1 = 5;
f2 = 8;
cs1 = am*sin(2*pi*f1*t);
cs2 = am*sin(2*pi*f2*t);

subplot(4,1,2);
plot(t,cs1,'lineWidth',2);
grid on;
%axis([ 0 t(end)+1 -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Carrier Signal 1');

subplot(4,1,3);
plot(t,cs2,'lineWidth',2);
grid on;
%axis([ 0 t(end)+1 -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Carrier Signal 2');


%% Modulated Signal
mu_s = zeros(1,length(t));
for i=1:length(ms)
  if ms(i)==0
    mu_s(i)=cs1(i);
  else
    mu_s(i)=cs2(i);
  end
end

subplot(4,1,4);
plot(t,mu_s,'lineWidth',2);
grid on;
%axis([ 0 t(end)+1 -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Modulated Signal');