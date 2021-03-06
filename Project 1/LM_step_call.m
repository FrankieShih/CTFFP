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

% Call option

call_price=zeros(length(n_steps),1);

for i=1:length(n_steps)
    t= 0:dt(i):T;    

    sT = zeros(N,length(t));%stock prices
    sT(:,1) = s0; %set the initial stock price as the first element in the vector
    
    for step_num = 2 : length(t)
        sT(:,step_num) = sT(:,step_num-1).*(1 + r*dt(i) + sigma*sqrt(dt(i)).*randn(N,1));
    end
    
    call_payoff = max(sT(:,end)-K,0);
    discounted_call_payoff = call_payoff .* exp(-r.*T);
    mean_discounted_call_payoff = mean(discounted_call_payoff);
    call_price(i) = mean_discounted_call_payoff;

end
plot(n_steps,call_price);
hold on;
BS_call = 4.3654;
line([0,50],[BS_call,BS_call]);
ylim([4.34,4.44]);
xlabel('Number of step');
ylabel('Call option price');
title_str = sprintf('LM Call option');
title(title_str);
legend('M_price','BS_pric');