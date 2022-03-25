function [ x ] = part1( x,N,W,dt)
%PART1 Summary of this function goes here
%   Detailed explanation goes here
epsilon=normrnd(0,0.5,N,1);%Õ‚¬“

k1=W*tanh(x)-x;
k2=W*tanh(x+dt./2.*k1)-(x+dt./2.*k1);
k3=W*tanh(x+dt./2*k2)-(x+dt./2.*k2);
k4=W*tanh(x+dt.*k3)-(x+dt.*k3);
%x=x+dt/6*(k1+2.*k2+2.*k3+k4)+dt*epsilon;
x=x+dt/6*(k1+2.*k2+2.*k3+k4);
end
