close all;
clear all;
clc;

%--------------------------------------------------------------------
%Constants
T = 1/12;    
K = 46;     %strike price
r = 0.0077; %risk free interest rate, per annum
d = 0;      %dividend rate. In our project, we ues adjusted price, so d=0.
%company = "UAA";
company = "LM";
%--------------------------------------------------------------------

[price_UAA_LM,price_UAA,price_LM,first_Date,last_Date,count_Date]...
    = clean_data("price_UAA_LM.xlsx");

%Validation via Monte Carlo

rng('default');  %seed

sigma = std(log(price_LM(2:end)./price_LM(1:end-1)))*sqrt(252);

s0 = price_LM(end);

N = 1e6;
n_steps = 1:1:50; %number of steps in the stock price path
dt = T ./ n_steps; %size of steps (in years) in the stock price path

% Put option

put_price=zeros(length(n_steps),1);

for i=1:length(n_steps)
    t= 0:dt(i):T;    

    sT = zeros(N,length(t));%stock prices
    sT(:,1) = s0; %set the initial stock price as the first element in the vector
    
    for step_num = 2 : length(t)
        sT(:,step_num) = sT(:,step_num-1).*(1 + r*dt(i) + sigma*sqrt(dt(i)).*randn(N,1));
    end
    
    put_payoff = max(K-sT(:,end),0);
    discounted_put_payoff = put_payoff .* exp(-r.*T);
    mean_discounted_put_payoff = mean(discounted_put_payoff);
    put_price(i) = mean_discounted_put_payoff;

end
plot(n_steps,put_price);
hold on;
BS_put = 0.3859;
line([0,50],[BS_put,BS_put]);
ylim([0.37,0.6]);
xlabel('Number of step');
ylabel('Put option price');
title_str = sprintf('LM put option');
title(title_str);
legend('M_price','BS_pric');