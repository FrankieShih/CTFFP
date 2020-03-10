close all;
clear all;
clc;

%--------------------------------------------------------------------
%Constants
K = 13;     %strike price
r = 0.0077;   %risk free interest rate, per annum
d = 0;      %dividend rate. In our project, we ues adjusted price, so d=0.
company = "UAA";
%company = "LM";
%--------------------------------------------------------------------

[price_UAA_LM,price_UAA,price_LM,first_Date,last_Date,count_Date]...
    = clean_data("price_UAA_LM.xlsx");

%Validation via Monte Carlo

rng('default');  %seed

dt = 1/12;  % maturity in years

R_UAA = (log(price_UAA(end)/price_UAA(1))+1).^(1/10)-1;  %annualy rate
sigma = std(log(price_UAA(2:end)./price_UAA(1:end-1)))*sqrt(252);

drift = (r-sigma^2/2)*dt;
diffusion = sigma*sqrt(dt);
s0 = price_UAA(end);

power = 1:6;
N = 10.^power;

%% call option

price_UAA_call = zeros(length(N),1);

% show convergency
for i = 1 : length(N)
    
    current_N = N(i);
    sT = s0*exp( drift + diffusion*randn(current_N,1) ); 
    call_payoff = max(sT-K,0);
    discounted_call_payoff = call_payoff * exp(-r*dt);
    mean_discounted_payoff = mean(discounted_call_payoff) ;
    
    %Store the results of this Monte Carlo simulation (with N = current_N)
    %to display when all MC simulations are complete. 
    price_UAA_call(i) = mean_discounted_payoff;
    
end

fprintf('%10s %8s\n','N','price_UAA_call');
fprintf('%10d %8.2f\n',[N; price_UAA_call']);
fprintf('\n');

%% put option

price_UAA_put = zeros(length(N),1);

% show convergency
for i = 1 : length(N)
    
    current_N = N(i);
    sT = s0*exp( drift + diffusion*randn(current_N,1) ); 
    put_payoff = max(K-sT,0);
    discounted_put_payoff = put_payoff * exp(-r*dt);
    mean_discounted_payoff = mean(discounted_put_payoff) ;
    
    %Store the results of this Monte Carlo simulation (with N = current_N)
    %to display when all MC simulations are complete. 
    price_UAA_put(i) = mean_discounted_payoff;
    
end

fprintf('%10s %8s\n','N','price_UAA_put');
fprintf('%10d %8.2f\n',[N; price_UAA_put']);
fprintf('\n');

%% digital call option

price_UAA_d_call = zeros(length(N),1);

% show convergency
for i = 1 : length(N)
    
    current_N = N(i);
    sT = s0*exp( drift + diffusion*randn(current_N,1) );
    d_call_payoff = (sT>K) * K;
    
    discounted_d_call_payoff = d_call_payoff * exp(-r*dt);   
    discounted_mean_payoff = mean(discounted_d_call_payoff);
    
    %Store the results of this Monte Carlo simulation (with N = current_N)
    %to display when all MC simulations are complete. 
    price_UAA_d_call(i) = discounted_mean_payoff;
    
end

fprintf('%10s %8s\n','N','price_UAA_d_call');
fprintf('%10d %8.2f\n',[N; price_UAA_d_call']);
fprintf('\n');

%% digital put option

price_UAA_d_put = zeros(length(N),1);

% show convergency
for i = 1 : length(N)
    
    current_N = N(i);
    sT = s0*exp( drift + diffusion*randn(current_N,1) );
    d_call_payoff = (sT<K) * K;
    
    discounted_d_put_payoff = d_call_payoff * exp(-r*dt);   
    discounted_mean_payoff = mean(discounted_d_put_payoff);
    
    %Store the results of this Monte Carlo simulation (with N = current_N)
    %to display when all MC simulations are complete. 
    price_UAA_d_put(i) = discounted_mean_payoff;
    
end

fprintf('%10s %8s\n','N','price_UAA_d_put');
fprintf('%10d %8.2f\n',[N; price_UAA_d_put']);
fprintf('\n');