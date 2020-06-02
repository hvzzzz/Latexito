
function [qt, tau] = alg_control(t,x,xp)
q = [x(1); x(2)];   % Posiciones
qp = [xp(1); xp(2)]; %Velocidades

%referencias
qd1=90; % cinem�tica inversa
qd2=90;
qd=[qd1; qd2];  %Vector de referencias

tau_max_h=150;
tau_max_c=15;
fqd1=((1+tanh(qd1)*tanh(qd1)))/tanh(qd1);
fqd2=((1+tanh(qd2)*tanh(qd2)))/tanh(qd2);
%kp1=0.8*10; %% menor que tau_max=150  (hombro)
%kp2=0.8*5; %%% menor que tau_max=15 (codo)
kp1=tau_max_h*fqd1;
kp2=tau_max_c*fqd2;
Kp=[kp1, 0; 0, kp2];  % Ganancia proporcional

 m=299; %sin m la cota m�xima de m=299

kv1=0.5*kp1;
kv2=0.5*kp2;
Kv=[kv1,  0; 0, kv2]; %Ganancia derivativa

 % Vector de pares de gravitacionales
    par_grav = [38.46*sin(q(1))+1.82*sin(q(1)+q(2));
               1.82*sin(q(1)+q(2))       ];

 qt=[pi*qd(1)/180-q(1); pi*qd(2)/180-q(2)];
 %Error de posici�n en grados
  qtgrados=(180/pi)*[qt(1) ;qt(2)]; 
  %velocidad en grados/segundo.
  
 
  qpgrados=180*qp/pi;
  
 
  
   %control_p=[sinh(qt(1,1))*cosh(qt(1,1))^(m-1)/(1+cosh(qt(1,1))^(m));
                      %sinh(qt(2,1))*cosh(qt(2,1))^(m-1)/(1+cosh(qt(2,1))^(m))];

  %accion_d=[sinh(qp(1,1))*cosh(qp(1,1))^(m-1)/(1+cosh(qp(1,1))^(m));
                    %sinh(qp(2,1))*cosh(qp(2,1))^(m-1)/(1+cosh(qp(2,1))^(m))];
  hyper_p=[1/(cosh(qt(1,1))*cosh(qt(1,1)))*(tanh(qt(1,1)))/(1+tanh(qt(1,1))*tanh(qt(1,1)));
      1/(cosh(qt(2,1))*cosh(qt(2,1)))*(tanh(qt(2,1)))/(1+tanh(qt(2,1))*tanh(qt(2,1)))];
  hyper_d=[atan(qp(1,1));
      atan(qp(2,1))];
  tau=Kp*hyper_p-Kv*hyper_d+par_grav;
  %tau=Kp*control_p-Kv*accion_d+par_grav;
%tau=Kp*qt-Kv*qp+par_grav;
 % tau=Kp*tanh(qt)-Kv*tanh(qp)+par_grav;
  %tau=Kp*atan(qt)-Kv*atan(qp)+par_grav;

end





