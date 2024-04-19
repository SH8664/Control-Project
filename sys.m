clear;
close all;
clc;
B1=tf(1,[100,0,0]);
B2=tf([100,0],1);
B3=tf(50,1);
B4=tf(5,1);
B5=tf(1,[100,0,0]);
B6=tf([100,0],1);
B7=tf(50,1);
B8=tf(5,1);
B9=tf(50,1);
B10=tf(50,1);

BlockMat=append(B1,B2,B3,B4,B5,B6,B7,B8,B9,B10);
input_loc=1;
output_loc=[1,5];

connect_map=[1,-2,-4, 9 ,-3 ;
             2, 1, 0, 0 , 0 ;
             3, 1, 0, 0 , 0 ;
             4, 1, 0, 0 , 0 ;
             5, -6,-7,-8,10 ;
             6, 5, 0, 0 , 0 ;
             7, 5, 0, 0 , 0 ;
             8, 5, 0, 0 , 0 ;
             9, 5, 0, 0 , 0 ;
             10,1, 0, 0 , 0 ;];
system=connect(BlockMat,connect_map,input_loc,output_loc);




% Plot the response using stepplot
transfer_fun = tf(system);
X1_U = transfer_fun(1);
X2_U = transfer_fun(2);
display(X1_U);
display(X2_U);


%test stability od X1
figure;
pzmap(X1_U);
hold on;

figure;
p=stepplot(system);
setoptions(p,'RiseTimeLimits',[0,1]);
hold on;

% Get step response information for each output
info_X1_U = stepinfo(X1_U);
info_X2_U = stepinfo(X2_U);




sys = feedback(X2_U,1);

figure;
p=stepplot(2*sys);
setoptions(p,'RiseTimeLimits',[0,1]);
title("response of X2 when Xd = 2m ");

disp(stepinfo(sys));

values = [1, 10,100,1000];
for i = 1 : length(values)
    Kp = values(i);
    display(Kp);
    sys = feedback(Kp*X2_U,1);
    figure;
    p=stepplot(2*sys);
    setoptions(p,'RiseTimeLimits',[0,1]);
    title(strcat("Transient Response Kp =  ",num2str(Kp)));
    hold on;
    disp(stepinfo(sys));
end


% Using PI controller 
Kp = 91;
Ki = 8;
PI_controller = tf([Kp Ki], [1 0]);
sys = feedback(PI_controller*X2_U,1);
figure;
t = 0:0.01:10; % Adjust time vector as needed
[y, t] = step(4*sys, t);
p=stepplot(4*sys);
setoptions(p,'RiseTimeLimits',[0,1]);
title(strcat("Transient Response Kp =  ",num2str(Kp)," and Ki =  ",num2str(Ki)));
hold on;
disp("Error = ")
disp(4-y(end));
disp(stepinfo(sys));