clear; clc;
s=[0.1:0.1:100]';
k=46;
r=0.0077;
vol=0.4266;
t=1/12;
%delta
delta = blsdelta(s,k,r,t,vol);
%graph1
figure;
plot(s,delta);
title('The Delta of a call option as a function of spot');
ylabel('delta');
xlabel('s');

%graph2
t_2yrs=[1/12:1/12:2];
s_last_day=49.95;
k_in_the_money=40;
delta_in_the_money = blsdelta(s_last_day,k_in_the_money,r,t_2yrs,vol);
figure;
plot(t_2yrs,delta_in_the_money);
title('The Delta of a call option as a function of time-in the money');
ylabel('delta for in the money');
xlabel('maturity time');

k_at_the_money=49.95;
delta_at_the_money = blsdelta(s_last_day,k_at_the_money,r,t_2yrs,vol);
figure;
plot(t_2yrs,delta_at_the_money);
title('The Delta of a call option as a function of time-at the money');
ylabel('delta for at the money');
xlabel('maturity time');

k_out_the_money=60;
delta_out_the_money = blsdelta(s_last_day,k_out_the_money,r,t_2yrs,vol);
figure;
plot(t_2yrs,delta_out_the_money);
title('The Delta of a call option as a function of time-out the money');
ylabel('delta for out the money');
xlabel('maturity time');

%gamma
gamma = blsgamma(s,k,r,t,vol);
%graph3
figure;
plot(s,gamma);
title('The Gamma of a call option as a function of spot');
ylabel('gamma');
xlabel('s');

%vega
vega = blsvega(s,k,r,t,vol);

%graph4
vol_to1=[0.05:0.05:1];
vega_vol = blsvega(s_last_day,k,r,t,vol_to1);
figure;
plot(vol_to1,vega_vol);
title('The Vega of a call option as a function of volatility');
ylabel('vega');
xlabel('vol');

figure;
plot(s,vega);
title('The Vega of a call option as a function of spot');
ylabel('vega');
xlabel('s');

t_2yrs=[1/12:1/12:2];
vega_time = blsvega(s_last_day,k,r,t_2yrs,vol);
figure;
plot(t_2yrs,vega_time);
title('The vega of a call option as a function of time');
ylabel('vega');
xlabel('maturity time');

%rho
rho = blsrho(s,k,r,t,vol);

%theta
theta = blstheta(s,k,r,t,vol);
