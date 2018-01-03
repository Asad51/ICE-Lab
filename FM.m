%% Modulating Signal
am = 5;
fm = 10;
t = 0:0.001:1;
xm = am*sin(2*pi*fm*t);

subplot(3,1,1); 
plot(t,xm), grid on;% Graphical representation of Modulating signal
title ( '  Modulating Signal   ');
xlabel ( ' time(sec) ');
ylabel (' Amplitud(volt)   ');

%% Carrier Signal
ac = 10;
fc = 40;
xc = ac*sin(2*pi*fc*t);

subplot(3,1,2); 
plot(t,xc), grid on;% Graphical representation of Modulating signal
title ( '  Carrier Signal   ');
xlabel ( ' time(sec) ');
ylabel (' Amplitud(volt)   ');

%% modulated signal
m = 10; %modulation index
y = ac*sin(2*pi*fc*t + m*sin(2*pi*fm*t));

subplot(3,1,3); 
plot(t,y), grid on;% Graphical representation of Modulating signal
title ( '  Modulated Signal   ');
xlabel ( ' time(sec) ');
ylabel (' Amplitud(volt)   ');
