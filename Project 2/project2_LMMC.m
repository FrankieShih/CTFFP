clear; clc;
s=[0.1:0.1:100]';
k=46;
r=0.0077;
vol=0.4266;
t=1/12;
%delta
for i=1:1000
delta(i,1) = blsdelta(s(i),k,r,t,vol);
end

%MC simulation on delta
rand('seed',1);
ep1=0.0001*rand(1000,1);
Y=sort(ep1);
for i=1:1000
BS1(i)=blsprice(s(i)+Y(i),k,r,t,vol);
BS(i)=blsprice(s(i),k,r,t,vol);
delta(i,2)=1/Y(i)*(BS1(i)-BS(i));
end
figure
plot(s,delta(:,1),"g-o")
hold on;
plot (s,delta(:,2),"red");
legend("BSformula","MC");
title('The Delta of a call option as a function of spot of LM');
ylabel('delta');
xlabel('s');
hold off;

%gamma
for i=1:1000
gamma(i,1) = blsgamma(s(i),k,r,t,vol);
end

%MC simulation for gamma
for i=1:1000
    BS2p(i)=blsprice(s(i)+Y(i),k,r,t,vol);
    BS2(i)=blsprice(s(i),k,r,t,vol);
    BS2m(i)=blsprice(s(i)-Y(i),k,r,t,vol);
    gamma(i,2)=(1/(Y(i)*Y(i)))*(BS2p(i)-2*BS2(i)+BS2m(i));
end
figure
plot(s,gamma(:,1),"green-o")
hold on;
plot (s,gamma(:,2),"red");
legend("BSformula","MC");
title('The Gamma of a call option as a function of spot of LM');
ylabel('Gamma');
xlabel('s');
hold off;

%second MC, delta
ep2=0.01*rand(1000,1);
X=sort(ep2);
for i=1:1000
BS1(i)=blsprice(s(i)+X(i),k,r,t,vol);
BS(i)=blsprice(s(i),k,r,t,vol);
delta(i,3)=1/X(i)*(BS1(i)-BS(i));
end
figure;
plot(s,delta(:,1),"black-o");
hold on;
plot(s,delta(:,3),"yellow--");
legend("BSformula","MC2");
title('The Delta of a call option as a function of spot of LM');
ylabel('delta');
xlabel('s');
hold off;
%second MC, Gamma
for i=1:1000
    BS2p(i)=blsprice(s(i)+X(i),k,r,t,vol);
    BS2(i)=blsprice(s(i),k,r,t,vol);
    BS2m(i)=blsprice(s(i)-X(i),k,r,t,vol);
    gamma(i,3)=(1/(X(i)*X(i)))*(BS2p(i)-2*BS2(i)+BS2m(i));
end
figure
plot(s,gamma(:,1),"black-o")
hold on;
plot (s,gamma(:,3),"yellow");
legend("BSformula","MC2");
title('The Gamma of a call option as a function of spot of LM');
ylabel('Gamma');
xlabel('s');
hold off;