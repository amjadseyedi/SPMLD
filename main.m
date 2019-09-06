clc;clear;
addpath('clf');
addpath('lib');
addpath(genpath('lib/manopt'));
addpath('evl');

dat0='dt/Computers.mat'; %Change Dataset

[obj_old,tstv2,P,lambda,gamma,in_result, out_result] = run_arts(dat0);
out_result = rmfield(out_result, 'time');
in_result(1).type='Recovery 70%';
in_result(2).type='Recovery 30%';
out_result(1).type='Prediction 70%';
out_result(2).type='Prediction 30%';
T = struct2table([in_result;out_result]);
T = movevars(T, 'type', 'Before', 'Coverage');
 disp(T)
 plot(obj_old)