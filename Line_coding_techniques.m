%unipolar 
clc;
clear;
signal = [0,1,0,1,1];
voltage_level = 5;

bit_diff = 1;
t = 0:0.01:length(signal);

for j =1:length(t)
    if t(j) < bit_diff;
        unipolar_signal(j) = signal(bit_diff)*voltage_level;
    else 
        unipolar_signal(j) = signal(bit_diff)*voltage_level;
        bit_diff = bit_diff + 1;     
    end   
end

plot(t,unipolar_signal,'g');

%demodulation

total_time = length(signal);
bit_rate = 1;
index = 1;
bit_points = (length(unipolar_signal)-1)/(total_time*bit_rate);
temp = bit_points;
voltage_l = 5;
for j =1:length(unipolar_signal)
    if j < temp
    else 
        demodulated_signal(index) = abs(unipolar_signal(j))/voltage_l;
        index=index+1;
        temp = temp + bit_points;
    end   
end

demodulated_signal
%% NRZ LEVEL

signal = [1,1,0,1,1];
voltage_level = 5

bit_diff = 1;
t = 0:0.01:length(signal);

for j =1:length(t)
    if(signal(bit_diff)==0)
            temp = -1;
    else temp = 1;
    end
    if t(j) < bit_diff;
        polar_signal(j) = temp*voltage_level;
    else 
        polar_signal(j) = temp*voltage_level;
        bit_diff = bit_diff + 1;     
    end   
end 


%plot

plot(t,polar_signal,'r');
grid on;
axis([0 length(signal) -6 6])

%% NRZ INVERSE

signal = [1,0,1,1,1];

%for i=1:5
    %signal(i)=input('');
    
%end
    

voltage_level = 5

temp=1;
bit_diff = 1;
t = 0:0.01:length(signal);

for j =1:length(t)

    if t(j) < bit_diff;
        polar_signal_inverse(j) = temp*voltage_level;
    else 
        polar_signal_inverse(j) = temp*voltage_level;
        
        if(bit_diff==length(signal))
            bit_diff = bit_diff-1;
        end
        bit_diff = bit_diff + 1; 
        
            
        if(signal(bit_diff)==1)
            temp = -temp;
         %else temp = 1;
         end
    end   
end 


%plot

plot(t,polar_signal_inverse,'r');
grid on;
axis([0 length(signal) -6 6])

%% Manchester

signal = [1,0,1,1,1];

%for i=1:5
    %signal(i)=input('');
    
%end
    

voltage_level = 5;

for i = 1:1:length(signal)
    if (signal(i)==0)
        temp_signal(i)= voltage_level;
    else 
        temp_signal(i)=-voltage_level;
    end
end



temp=1;
bit_diff = 1;
t = 0:0.01:length(signal);

for j =1:length(t)

    if t(j) < bit_diff;
        if t(j)> (bit_diff-0.5)
            polar_signal_manchester(j) =-temp_signal(bit_diff);
        else
            polar_signal_manchester(j) = temp_signal(bit_diff);
        end
    else 
        polar_signal_manchester(j) =-temp_signal(bit_diff);
        
        if(bit_diff==length(signal))
            bit_diff = bit_diff-1;
        end
        bit_diff = bit_diff + 1; 
        
            
        if(signal(bit_diff)==1)
            temp = -temp;
         %else temp = 1;
         end
    end   
end 


%plot

plot(t,polar_signal_manchester,'r');
grid on;
axis([0 length(signal) -6 6])


%% Return to Zero

signal = [1,0,1,1,1];

%for i=1:5
    %signal(i)=input('');
    
%end
    

voltage_level = 5;

for i = 1:1:length(signal)
    if (signal(i)==0)
        temp_signal(i)= -voltage_level;
    else 
        temp_signal(i)=voltage_level;
    end
end



temp=1;
bit_diff = 1;
t = 0:0.01:length(signal);

for j =1:length(t)

    if t(j) < bit_diff;
        if t(j)> (bit_diff-0.5)
            polar_signal_manchester(j) = 0;
        else
            polar_signal_manchester(j) = temp_signal(bit_diff);
        end
    else 
        polar_signal_manchester(j) = 0;
        
        if(bit_diff==length(signal))
            bit_diff = bit_diff-1;
        end
        bit_diff = bit_diff + 1; 
        
            
        if(signal(bit_diff)==1)
            temp = -temp;
         %else temp = 1;
         end
    end   
end 


%plot

plot(t,polar_signal_manchester,'r');
grid on;
axis([0 length(signal) -6 6])

%% Differential Manchester

signal = [0,1,0,1,1];

voltage_level = 5;

temp=1;
bit_diff = 1;
t = 0:0.01:length(signal);

for j =1:length(t)
    if(t(j)==0)
        if(signal(bit_diff)==0)
            voltage_level = -voltage_level;
        end
    end
        
    if t(j) < bit_diff;
        if t(j)> (bit_diff-0.5)
            polar_signal_manchester(j) =voltage_level;
        else
            polar_signal_manchester(j) =voltage_level;
            if(t(j)==bit_diff-0.5)
                voltage_level = -voltage_level;
            end
        end
    else 
        polar_signal_manchester(j) = voltage_level;
     
        if(bit_diff==length(signal))
            bit_diff = bit_diff-1;
            
        else
           if(signal(bit_diff+1)==0)
                 voltage_level = -voltage_level;
           
        end
            
        end
        bit_diff = bit_diff + 1; 
        
            
        if(signal(bit_diff)==1)
            temp = -temp;
         %else temp = 1;
         end
    end   
end 


%plot

plot(t,polar_signal_manchester,'r');
grid on;
axis([0 length(signal) -6 6])


%% AMI

signal = [1,0,1,1,1];  

voltage_level = 5;

temp=1;
bit_diff = 1;
t = 0:0.01:length(signal);

for j =1:length(t)

    if t(j) < bit_diff;
        if(signal(bit_diff)==1)
            signal_AMI(j) = voltage_level;
        end
        if(signal(bit_diff)==0)
            signal_AMI(j)= 0;
        end
    else 
        if(signal(bit_diff)==1)
            signal_AMI(j) = voltage_level;
            voltage_level = -voltage_level;
        end
        if(signal(bit_diff)==0)
            signal_AMI(j)= 0;
        end
        
        if(bit_diff==length(signal))
            bit_diff = bit_diff-1;
        end
        bit_diff = bit_diff + 1; 
    end   
end 


%plot

plot(t,signal_AMI,'r');
grid on;
axis([0 length(signal) -6 6])

%demodulation

total_time = length(signal);
bit_rate = 1;
index = 1;
bit_points = (length(signal_AMI)-1)/(total_time*bit_rate);
temp = bit_points;
voltage_l = 5;
for j =1:length(signal_AMI)
    if j < temp
    else 
        demodulated_signal(index) = abs(signal_AMI(j))/voltage_l;
        index=index+1;
        temp = temp + bit_points;
    end   
end

demodulated_signal

%% MLT-3

signal = [1,0,0,1,1,1,1];  

voltage_level = 5;
same_level = voltage_level;
opposite_level = - same_level;

check_nonzero_level=1;
bit_diff = 1;
t = 0:0.01:length(signal);

for j =1:length(t)

    if t(j) < bit_diff;
        if(signal(bit_diff)==0)
            if(check_nonzero_level==1)
               signal_MLT(j) = same_level;
            end
            if(check_nonzero_level==0)
               signal_MLT(j) = 0;
            end 
        end
        if(signal(bit_diff)==1)
            if(check_nonzero_level==1 && j==1)
                signal_MLT(j) = same_level;
            elseif(check_nonzero_level==1)
                signal_MLT(j) = 0;
            end
            if(check_nonzero_level==0)
                signal_MLT(j) = opposite_level;
            end
        
        end
    else 
        if(signal(bit_diff)==1)
            if(check_nonzero_level==0)
                signal_MLT(j) = opposite_level;
                same_level = opposite_level;
                opposite_level = -same_level;
                check_nonzero_level = 1;
            elseif(check_nonzero_level==1)
                signal_MLT(j) = 0;
                check_nonzero_level = 0;
            end 
        end  
        
        if(signal(bit_diff)==0)
            if(check_nonzero_level==1)
               signal_MLT(j) = same_level;
               opposite_level = -same_level;
            end
            if(check_nonzero_level==0)
               signal_MLT(j) = 0;
               %check_nonzero_level=0;
            end 
        end
        
        if(bit_diff==length(signal))
           % bit_diff = bit_diff-1;
        end
        bit_diff = bit_diff + 1; 
    end   
end 


%plot

plot(t,signal_MLT,'r');
grid on;
axis([0 length(signal) -6 6])

%demodulation

total_time = length(signal);
bit_rate = 1;
index = 1;
bit_points = (length(signal_MLT)-1)/(total_time*bit_rate);
temp = bit_points;
voltage_l = 5;
for j =1:length(signal_MLT)
    if j < temp
    elseif j==bit_points
        if (signal_MLT(1) == 0 && signal_MLT(bit_points)==0)
             demodulated_signal(1) = 0;
        elseif (signal_MLT(1) ~= 0 && signal_MLT(bit_points)==0)
             demodulated_signal(1) = 1;
        end
        index=index+1;
        temp = temp + bit_points;
    else 
        if (signal_MLT(j-bit_points) == 0 && signal_MLT(j) ~=0)
             demodulated_signal(index) = 1;
        elseif (signal_MLT(j-bit_points) ~= 0 && signal_MLT(j) ~=0)
             demodulated_signal(index) = 0;
        elseif (signal_MLT(j-bit_points) == 0 && signal_MLT(j) ==0)
             demodulated_signal(index) = 0;
        elseif (signal_MLT(j-bit_points) ~= 0 && signal_MLT(j)==0)
             demodulated_signal(index) = 1;
        end
        
        
        index=index+1;
        temp = temp + bit_points;
    end   
end

demodulated_signal
%% 2B1Q

signal = [1,0,1,1,0,1,0,0];  

zero_zero = -3;
zero_one = -1;
one_zero = 3;
one_one  = 1;

temp=1;
bit_diff = 1;
bit_duration = 0.5;
len = length(signal)/2;
t = 0:0.001:len;

for j =1:length(t)

    if t(j) < (bit_diff*bit_duration)+ bit_duration
        if(signal(bit_diff)==1 && signal(bit_diff+1)==1)
            signal_2blq(j) = one_one;
        end
        if(signal(bit_diff)==1 && signal(bit_diff+1)==0)
            signal_2blq(j) = one_zero;
        end
        if(signal(bit_diff)==0 && signal(bit_diff+1)==1)
            signal_2blq(j) = zero_one;
        end
        if(signal(bit_diff)==0 && signal(bit_diff+1)==0)
            signal_2blq(j) = zero_zero;
        end
    elseif t(j) == (bit_diff*bit_duration)+ bit_duration
        if(signal(bit_diff)==1 && signal(bit_diff+1)==1)
            signal_2blq(j) = one_one;
        end
        if(signal(bit_diff)==1 && signal(bit_diff+1)==0)
            signal_2blq(j) = one_zero;
        end
        if(signal(bit_diff)==0 && signal(bit_diff+1)==1)
            signal_2blq(j) = zero_one;
        end
        if(signal(bit_diff)==0 && signal(bit_diff+1)==0)
            signal_2blq(j) = zero_zero;
        end
        bit_diff = bit_diff + 2; 
    end
end 

%plot

plot(t,signal_2blq,'r');
grid on;
axis([0 length(signal) -4 4])


%demodulation

zero_zero = -3;
zero_one = -1;
one_zero = 3;
one_one  = 1;

total_time = length(signal);
index=1;
bit_rate = 1;
bit_duration = 0.5;
bit_points = (length(signal_2blq)-1)/(total_time*bit_rate*bit_duration);
temp = bit_points;
for j =1:length(signal_2blq)
    if j < temp
    else 
        if signal_2blq(j)==zero_zero
            demodulated_signal(index) = 0;
            demodulated_signal(index+1) =0;
        end
        if signal_2blq(j)==one_zero
            demodulated_signal(index) = 1;
            demodulated_signal(index+1) =0;
        end
        if signal_2blq(j)==zero_one
            demodulated_signal(index) = 0;
            demodulated_signal(index+1) =1;
        end
        if signal_2blq(j)==one_one
            demodulated_signal(index) = 1;
            demodulated_signal(index+1) =1;
        end
        
        
        index=index+2;
        temp = temp + bit_points;
    end   
end

demodulated_signal