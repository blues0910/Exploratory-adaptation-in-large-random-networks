function [ K ] = K( Node,N,gamma,x_min)
%K Summary of this function goes here
%   Detailed explanation goes here
tmp1=0;
tmp2=0;
for i=1:N
    tmp1=tmp1+Node(i).In_Degrees*((gamma*x_min^gamma)/Node(i).In_Degrees^(gamma+1));
    tmp2=tmp2+Node(i).Out_Degrees*((gamma*x_min^gamma)/Node(i).Out_Degrees^(gamma+1));
    
%     tmp1=tmp1+Node(i).In_Degrees*3.5/N;
%     tmp2=tmp2+Node(i).Out_Degrees*3.5/N;
end
K=(tmp1+tmp2)/2;

end

