ti=-10:0.001:10;
%f1=((cosh(ti).*cosh(ti)).*(1+tanh(ti).*tanh(ti)))./tanh(ti);
f1=((1+tanh(ti).*tanh(ti)))./tanh(ti);
f2=atan(ti);
%figure
%subplot(2,1,1)
plot(ti,f1)
%subplot(2,1,2)
%plot(ti,f2)