clc; clear all; close all;

a_true = -0.8;
b_true = 0.5;
c_true = -0.5;

max = 1000;
Noise = 0.7 * wgn(max, 1, 1);
y = zeros(max, 1);
u = zeros(max, 1);

%% Part a
u(1:50, 1) = ones(50, 1);
T = 100;

for i = 101:max
    u(i) = u(i - T);
end

for t = 2:max
    y(t) = 0.8 * y(t - 1) + 0.5 * u(t - 1) + Noise(t) - 0.5 * Noise(t - 1);
end

P = 100 * eye(2);
theta = zeros(2, 1);
a(1) = theta(1);
b(1) = theta(2);

% RLS Algorithm
for i = 2:max
    phiint = [-y(i - 1); u(i - 1)];
    K = P * phiint * inv(eye(1) + phiint' * P * phiint);
    theta = theta + K * (y(i) - phiint' * theta);
    P = (eye(2) - K * phiint') * P;
    a(i) = theta(1);
    b(i) = theta(2);
end

figure;
t = 1:max;
plot(t, a_true * ones(size(t)));
hold on;
plot(t, b_true * ones(size(t)));
hold on;
plot(a);
hold on;
plot(b);
grid on;
title('Part a Fig2-8');
xlabel('Time (second)');
legend('a','b','$$\hat{a}$$','$$\hat{b}$$','Interpreter','Latex');
hold off;

%% Part b

% ERLS Algorithm
P = 100 * eye(3);
theta = zeros(3, 1);
a(1) = theta(1);
b(1) = theta(2);
c(1) = theta(3);

for i = 2:max
    phiint = [-y(i - 1); u(i - 1); Noise(i - 1)];
    K = P * phiint * inv(eye(1) + phiint' * P * phiint);
    theta = theta + K * (y(i) - phiint' * theta);
    P = (eye(3) - K * phiint') * P;
    a(i) = theta(1);
    b(i) = theta(2);
    c(i) = theta(3);
end

figure;
t = 1:max;
plot(t, a_true * ones(size(t)));
hold on;
plot(t, b_true * ones(size(t)));
hold on;
plot(t, c_true * ones(size(t)));
hold on;
plot(a);
hold on;
plot(b);
hold on;
plot(c);
grid on;
title('Part b Fig2-8');
xlabel('Time (second)');
legend('a','b','c','$$\hat{a}$$','$$\hat{b}$$','$$\hat{c}$$','Interpreter','Latex');
hold off;