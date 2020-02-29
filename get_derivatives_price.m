function price_Derivative = get_derivatives_price(T,r,d,K,S,sigma,type_derivative)
%get_derivatives_price is to calculate the price of derivatives
%using th Black-Scholes formula.
%Input:
%     T : Expiration time of the dericative;
%     r : Continuously compounding rate;
%     d : Dividend rate;
%     K : Strike price of the dericative;
%     S : Spot price of the stock at time 0;
%     sigma : Volatility of the stock
%     type_derivative: 0 -- forward
%                      1 -- call
%                      2 -- put
%                      3 -- digital-call
%                      4 -- digital-put
%                      5 -- zero-coupon bond                       
% Output:
%    price_Derivative  

% call&put parameters
d1 = (log(S/K) + (r + sigma^2/2)*T) / (sigam * sqrt(T));
d2 = d1 - sigma*sqrt(T);
% digital call&put parmeters
dd = (log(K/S)-(r-sigma^2/2)*T) / (sigam * sqrt(T));

switch type_derivative
    case 0 % forward contract
        price_Derivative = S - K * exp(-r*T);
    case 1 % call option
        price_Derivative = S * normcdf(d1) - K * exp(-r*T) * normcdf(d2);
    case 2 % put option
        price_Derivative =  K * exp(-r*T) * normcdf(-d2) - S * normcdf(-d1);
    case 3 % digital call option
        price_Derivative = exp(-r*T) * normcdf(-dd);
    case 4 %  digital put option
        price_Derivative = exp(-r*T) * normcdf(dd);
    otherwise % zero coupon bond
        price_Derivative = K * exp(-r*T);
end %switch

end %funtion

