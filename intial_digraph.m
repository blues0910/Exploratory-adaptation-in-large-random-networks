function [ Node,ZeroIn_Node_Set ] = intial_digraph( D,N )
%INTIAL Summary of this function goes here
%   Detailed explanation goes here

%D is a BDS£»D(:,1) is in-degrees of each node; D(:,2) is out-degrees of
%each node
%restore ordering inceasingly by in-degrees
ZeroIn_Node_Set=[];
for i=1:N
    Node(i).Index=D(i,3);
    Node(i).In_Degrees=D(i,1);
    Node(i).Out_Degrees=D(i,2);
    Node(i).Re_In_Degrees=Node(i).In_Degrees;
    if Node(i).Re_In_Degrees==0
        ZeroIn_Node_Set=union(ZeroIn_Node_Set,Node(i).Index);
    end
    Node(i).Re_Out_Degrees=Node(i).Out_Degrees;
    Node(i).TargetNode_Set=[];
end

end

