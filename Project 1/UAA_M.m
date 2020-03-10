close all;
clear all;
clc;

%--------------------------------------------------------------------
%Constants
T = 1/12;  % maturity in years
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

sigma = std(log(price_UAA(2:end)./price_UAA(1:end-1)))*sqrt(252);

s0 = price_UAA(end);

power = 1:6;
N = 10.^power;
n_steps = 50; %number of steps in the stock price path
dt = T / n_steps; %size of steps (in years) in the stock price path
t = 0:dt:T;

%Call option

call_price=zeros(length(N),1);

% show convergency
for i=1:length(N)
  sT = zeros(N(i),length(t)); %stock prices
  sT(:,1) = s0; %set the initial stock price as the first element in the vector
  
  for step_num = 2 : length(t)
    sT(:,step_num) = sT(:,step_num-1).*(1 + r*dt + sigma*sqrt(dt).*randn(N(i),1));
  end
  
   call_payoff = max(sT(:,end)-K,0);
   discounted_call_payoff = call_payoff .* exp(-r.*T);
   mean_discounted_call_payoff = mean(discounted_call_payoff);
   call_price(i) = mean_discounted_call_payoff;
end

fprintf('%10s %8s\n','N','UAA_call_price');
fprintf('%10d %8.2f\n',[N; call_price']);

% Put option

put_price=zeros(length(N),1);

% show convergency
for i=1:length(N)
  sT = zeros(N(i),length(t)); %stock prices
  sT(:,1) = s0; %set the initial stock price as the first element in the vector
  
  for step_num = 2 : length(t)
    sT(:,step_num) = sT(:,step_num-1).*(1 + r*dt + sigma*sqrt(dt).*randn(N(i),1));
  end
  
   put_payoff = max(K-sT(:,end),0);
   discounted_put_payoff = put_payoff .* exp(-r.*T);
   mean_discounted_put_payoff = mean(discounted_put_payoff);
   put_price(i) = mean_discounted_put_payoff;
end

fprintf('%10s %8s\n','N','UAA_call_price');
fprintf('%10d %8.2f\n',[N; put_price']);

%Digital call option

d_call_price=zeros(length(N),1);

% show convergency
for i=1:length(N)
  sT = zeros(N(i),length(t)); %stock prices
  sT(:,1) = s0; %set the initial stock price as the first element in the vector
  
  for step_num = 2 : length(t)
    sT(:,step_num) = sT(:,step_num-1).*(1 + r*dt + sigma*sqrt(dt).*randn(N(i),1));
  end
  
   d_call_payoff = (sT(:,end)>K) * K;
   discounted_d_call_payoff = d_call_payoff .* exp(-r.*T);
   mean_discounted_d_call_payoff = mean(discounted_d_call_payoff);
   d_call_price(i) = mean_discounted_d_call_payoff;
end

fprintf('%10s %8s\n','N','UAA_d_call_price');
fprintf('%10d %8.2f\n',[N; d_call_price']);

% Put option

d_put_price=zeros(length(N),1);

% show convergency
for i=1:length(N)
  sT = zeros(N(i),length(t)); %stock prices
  sT(:,1) = s0; %set the initial stock price as the first element in the vector
  
  for step_num = 2 : length(t)
    sT(:,step_num) = sT(:,step_num-1).*(1 + r*dt + sigma*sqrt(dt).*randn(N(i),1));
  end
  
   d_put_payoff = (sT(:,end)<K) * K;
   discounted_d_put_payoff = d_put_payoff .* exp(-r.*T);
   mean_discounted_d_put_payoff = mean(discounted_d_put_payoff);
   d_put_price(i) = mean_discounted_d_put_payoff;
end

fprintf('%10s %8s\n','N','UAA_d_call_price');
fprintf('%10d %8.2f\n',[N; d_put_price']);