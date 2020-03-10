close all;
clear all;
clc;

%--------------------------------------------------------------------
%Constants
company = "LM";
T = 1/12;    %maturity
r = 0.0077;  %continuously compounding rate
d = 0;      %dividend rate. In our project, we ues adjusted price, so d=0.
if company == "LM"
    S0 = 49.95;
    sigma = 0.3035;
    K = 46;     %strike price
else
    S0 = 13.99;
    sigma = 0.4266;
    K = 13;     %strike price
end
%--------------------------------------------------------------------

[price_UAA_LM,price_UAA,price_LM,first_Date,last_Date,count_Date]...
    = clean_data("price_UAA_LM.xlsx");

for i=0:5
    fprintf("The price of %s derivative %d is %6.4f\n",company,i,get_derivatives_price(T,r,d,K,S0,sigma,i));
end
%--------------------------------------------------------------------
% consistency check
%(1)
if (get_derivatives_price(T,r,d,K,S0,sigma,0)+get_derivatives_price(T,r,d,K,S0,sigma,2)-get_derivatives_price(T,r,d,K,S0,sigma,1)<0.001)
    fprintf("The price of a call minus the price of a put equals the value of a forward\n");
else
    fprintf("The price of a call minus the price of a put is not equal to the value of a forward\n");
end
%(2)
y = zeros(length([0:20]),1);
for i = 0:20
    y(i+1) = get_derivatives_price(T,r,d,K*(3/2)/20*i,S0,sigma,1);
end
figure;
plot([0:20]*K*3/2/20,y);
title('A call option ptice is monotone decreasing with strike price');
ylabel("The Call Option Price");
xlabel("Strike Price");

%(3)
fprintf("S:%6.4f\n",S0);
fprintf("Call Price:%6.4f\n",get_derivatives_price(T,r,d,K,S0,sigma,1));
fprintf("S - K*exp(-r*T):%6.4f\n",S0 - K*exp(-r*T));
%(4)
y = zeros(length([0:20]),1);
for i = 0:20
    y(i+1) = get_derivatives_price(T,r,d,K,S0,(i+1)*0.05,1);
end
figure;
plot(0:20,y);
title('A call option ptice is monotone increasing in volatility');
ylabel("The Call Option Price");
xlabel("Volatility");
%(5)
y = zeros(length([0:20]),1);
for i = 0:20
    y(i+1) = get_derivatives_price(T*(i+1),r,d,K,S0,sigma,1);
end
figure;
plot(0:20,y);
title('A call option ptice is monotone increasing in volatility');
ylabel("The Call Option Price");
xlabel("Volatility");
%(6)
% See(2) convex curve
%(8)
if (get_derivatives_price(T,r,d,K,S0,sigma,3)+get_derivatives_price(T,r,d,K,S0,sigma,4)-get_derivatives_price(T,r,d,K,S0,sigma,5)<0.001)
    fprintf("The price of a call minus the price of a put equals the value of a forward\n");
else
    fprintf("The price of a digital call plus the price of a digital put is not equal to the value of a forward\n");
end

