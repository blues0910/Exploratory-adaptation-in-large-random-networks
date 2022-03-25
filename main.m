clear
N=100;
g0=10;
x_min=1;
gamma=2.4-1;
[T,Node]=Digraph(N,x_min,gamma,g0);
K=K(Node,N,gamma,x_min);
alpha=100;
c=0.2;
y_Asterisk=10;
b=normrnd(0,1/(g0^2*N*c)*alpha,1,N);
J0=normrnd(0,g0^2/K,N,N);

x0=randi([1,100],N,1);
Time_end=13000;
dt=0.05;
x=x0;
Omega=zeros(N,N);
J=J0;

f1=figure('Name','Show the Process of Computation');
%axis([0,Time_end/dt,-1000,1000]);
x_set=zeros(N,Time_end+1);
y_set=zeros(1,Time_end+1);
x_set(:,1)=x0;
y_set(1)=part3(x,b);
for i=0:dt:Time_end
    if i==2500
        y_Asterisk=-10;
    elseif i==5000
        y_Asterisk=30;
    elseif i==7500
        y_Asterisk=-20;
    elseif i==10000
        y_Asterisk=-30;
    end
    y=part3(x,b);
    J=part4(J,y,y_Asterisk,N,dt);
    W=part2(T,J);
    x=part1(x,N,W,dt);
    if mod(i,1)==0&&i>0
        x_set(:,int32(i+1))=x;
        y_set(int32(i+1))=y;
    end
%     plot(1:N,x0(:));
%     hold on
%     plot(1:N,x(:));
%     hold off
%     pause(0.000001);
end
for i=1:N
    plot(0:Time_end,x_set(i,:));
    hold on
end
xlabel('t','FontSize',16);
ylabel('x','FontSize',16);
% for i=0:Time_end
%     plot(i,sum(x_set(:,i+1)),'.');
%     hold on
% end
f2=figure('Name','Show the Process of y*');
eps=3;
%-----------------------------------------------------------
% x_tmp=linspace(0,Time_end);
% y_tmp=y_Asterisk.*x_tmp.^0;
% 
% y_eps_up=y_tmp+eps;
% y_eps_down=y_tmp-eps;
% plot(x_tmp,y_tmp,'r');
% 
% 
% plot(x_tmp,y_eps_up,'g');
% plot(x_tmp,y_eps_down,'g');
% 
% text(0,y_Asterisk+eps,'\rightarrow +¦Å');
% text(0,y_Asterisk-eps,'\rightarrow -¦Å');
% text(0,y_Asterisk,'\rightarrow y*');

%-----------------------------------------------------------
x_tmp1=linspace(0,2499);
x_tmp2=linspace(2500,4999);
x_tmp3=linspace(5000,7499);
x_tmp4=linspace(7500,9999);
x_tmp5=linspace(10000,Time_end);
y_tmp1=10.*x_tmp1.^0;
y_tmp2=-10.*x_tmp2.^0;
y_tmp3=30.*x_tmp3.^0;
y_tmp4=-20.*x_tmp4.^0;
y_tmp5=-30.*x_tmp5.^0;

plot(x_tmp1,y_tmp1,'r');
hold on
plot(x_tmp2,y_tmp2,'r');
plot(x_tmp3,y_tmp3,'r');
plot(x_tmp4,y_tmp4,'r');
plot(x_tmp5,y_tmp5,'r');

y_c1=linspace(10,-10);
y_c2=linspace(-10,30);
y_c3=linspace(30,-20);
y_c4=linspace(-20,-30);
x_c1=2500.*y_c1.^0;
x_c2=5000.*y_c2.^0;
x_c3=7500.*y_c3.^0;
x_c4=10000.*y_c4.^0;
plot(x_c1,y_c1,'r');
plot(x_c2,y_c2,'r');
plot(x_c3,y_c3,'r');
plot(x_c4,y_c4,'r');

plot(0:Time_end,y_set(:));

text(0,10,'\rightarrow y*=10');
text(2500,-10,'\rightarrow y*=-10');
text(5000,30,'\rightarrow y*=30');
text(7500,-20,'\rightarrow y*=-20');
text(10000,-30,'\rightarrow y*=-30');

xlabel('t','FontSize',16);
ylabel('y','FontSize',16);
