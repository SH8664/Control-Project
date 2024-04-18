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


%req4-->entering input 1N
% Define time vector for simulation
t = 0:0.01:10; % Define time from 0 to 10 seconds with a step of 0.01

% Generate step input signal
u = 1 * stepfun(t, 0); % 1N step input starting at t=0

% Simulate the system
[y, t, x] = lsim(system, u, t);

% Plot the response using stepplot
stepplot(system, t, y);

% Customize the plot
title('Step Response of the System to a 1N Step Input');
xlabel('Time (s)');
ylabel('Output');