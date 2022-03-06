%refer to Shingley's Mechanical Engineering Design to Fill in Blanks
clc
clear all
close all

%Some Starting Values
u_AVG = 0.15;%an average mu

%Desired Bolt Preload 
P_pre = 34000;%Newtons - for now we estimate 

%Geometric Parameters 
d = 12;%nominal bolt diameter in mm                                             CHANGE ME
d_major = 11.97; %mm                                                             CHANGE ME
d_minor = 10.619; %mm                                                            CHANGE ME
d_m = 0.5*(d_major+d_minor);%average of the major and minor diameters mm        
mu = u_AVG;%friction of threads                                                 (can change but don't need to)
mu_c = u_AVG;%friction with the face                                            (can change but don't need to)
alpha_deg = 30;%half the thread angle deg                                       (shouldn't need to change)
N = 1.25;%number of threads per mm                                              CHANGE ME

%Calculated Parameters
alpha = alpha_deg*pi/180; %convert to rads
thread_pitch = 1/N; %1/N
tan_psi = thread_pitch/(pi*d_m); %thread pitch over pi * dm

fprintf('K Nut Factor (unitless):\n')
K = d_m / (2*d) * ( ( tan_psi + mu*sec(alpha) ) / ( 1 - mu*tan_psi*sec(alpha) ) ) +  0.625 * mu_c
fprintf('T Torque Wrench Setting (N m):\n')
T = K * P_pre * d / 1000 %with default this works out to like 75Nm
T_est = 0.2 * P_pre * d / 1000 %with the approximation

%verification done for M12x1.25mm @ 90Nm is 34kN of force

%% This second section does some plotting for us
%%ASSUMING THE M12x1.25 we had earlier...
clear all

%Some Starting Values
u_AVG = 0.15;%an average mu

%Geometric Parameters 
d = 12;%nominal bolt diameter in mm                                             CHANGE ME
d_major = 11.97; %mm                                                             CHANGE ME
d_minor = 10.619; %mm                                                            CHANGE ME
d_m = 0.5*(d_major+d_minor);%average of the major and minor diameters mm        
mu = u_AVG;%friction of threads                                                 (can change but don't need to)
mu_c = u_AVG;%friction with the face                                            (can change but don't need to)
alpha_deg = 30;%half the thread angle deg                                       (shouldn't need to change)
N = 1.25;%number of threads per mm                                              CHANGE ME

%Calculated Parameters
alpha = alpha_deg*pi/180; %convert to rads
thread_pitch = 1/N; %1/N
tan_psi = thread_pitch/(pi*d_m); %thread pitch over pi * dm

P_pres = [0:1:70000];
Ts = [];
Ts_est = [];
for P_pre = P_pres
   K = d_m / (2*d) * ( ( tan_psi + mu*sec(alpha) ) / ( 1 - mu*tan_psi*sec(alpha) ) ) +  0.625 * mu_c; 
   T = K * P_pre * d / 1000;
   T_est = 0.2 * P_pre * d / 1000;
   Ts = [Ts, T];
   Ts_est = [Ts_est, T_est];
end

figure;
hold on
plot(P_pres, Ts);
plot(P_pres, Ts_est);
hold off
legend('True Preload', 'Estimated Preload K=0.2');
xlabel('Desired Preload in N')
ylabel('Required Torque in Nm')
title('Torque Wrench Setting vs. Desired Preload for M12x1.25 Bolt')



