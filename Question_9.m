% - Determine the system stability using MATLAB isStable function before and after PID in Z Domain. 

% Plant transfer function
numerator_plant = [10.06];
denominator_plant = [1, 2.646, 6.462, 5.49];

% PID controller parameters
Kp = 0.36962;
Ki = 0.50657;
Kd = 0.067425;

% Sampling time
Ts = 0.1;

% Setpoint
SP = 1;

disp("--------------------------------------------------------");

%% Determine the system stability before the PID tunning

sys_s = tf(numerator_plant, denominator_plant);
sys_z_c2d = c2d(sys_s, Ts, 'zoh'); 

% Check stability before PID control
isStable_before = isstable(sys_z_c2d);

% Display Stability Results Before PID Control
disp(['System Stability Before PID Control: ' num2str(isStable_before)]);

disp("--------------------------------------------------------");

%% Determine the system stability after the PID tunning

% PID controller transfer function
num_pid_s = [Kd, Kp, Ki];
den_pid_s = [1, 0];
sys_pid_s = tf(num_pid_s, den_pid_s);

% Discretize the PID controller transfer function
sys_pid_z = c2d(sys_pid_s, Ts, 'tustin');

% Closed-loop transfer function with unity feedback
sys_closed_loop = feedback(series(sys_z_c2d, sys_pid_z), 1);

% Check stability after PID control
isStable_after = isstable(sys_closed_loop);

% Display Stability Results After PID Control
disp(['System Stability After PID Control: ' num2str(isStable_after)]);

disp("--------------------------------------------------------");

%% Why we didn't use zoh ?
isStable_sys_pid_s = isstable(sys_pid_s);
disp(['Checking if the S Domain is stable to use ZOH: ' num2str(isStable_sys_pid_s)]);

% isstable = 1 then The system sys is stable.
% isstable = 2 then The system sys is stable.

disp("--------------------------------------------------------");