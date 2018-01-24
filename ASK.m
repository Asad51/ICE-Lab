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
subplot(3,1,1);
plot(t,ms,'lineWidth',2.5);
grid on;
%axis([ 0 t(end)+1 -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Message Signal');

%% Carrier Signal

fc = 5;
cs = am*sin(2*pi*fc*t);

subplot(3,1,2);
plot(t,cs,'lineWidth',2);
grid on;
%axis([ 0 t(end)+1 -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Carrier Signal');

%% Modulated Signal
mu_s = zeros(1,length(t));
for i=1:length(t)
  mu_s(i) = ms(i)*cs(i);
end

subplot(3,1,3);
plot(t,mu_s,'lineWidth',2);
grid on;
%axis([ 0 t(end)+1 -.5 1.5]);
ylabel('amplitude(volt)');
xlabel(' time(sec)');
title('Modulated Signal');


