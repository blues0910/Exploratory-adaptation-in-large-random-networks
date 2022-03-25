function [ J ] = part4( J,y,y_Asterisk,N,dt )
%PART4 Summary of this function goes here
%   Detailed explanation goes here
M0=2;
eps=3;
mu=0.01;
D=0.001;
dOmega=sqrt(dt)*randn(N,N);
M=M0/2*(1+tanh((abs(y-y_Asterisk)-eps)/mu));
dJ=sqrt(D*M)*dOmega;
J=J+dJ;
end

