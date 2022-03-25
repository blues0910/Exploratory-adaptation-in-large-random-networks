function [ A_Node_Set ] = A_Node_Set_Fun(N,D_bar,WorkNode_Index,X_Node_Set,Node)
%A_NODE_SET Summary of this function goes here
%   Detailed explanation goes here
%step3.1
A_Node_Set=[];
Node_Set=D_bar(:,3);
tmp_Node_Set=setdiff(Node_Set,X_Node_Set);
if Node(WorkNode_Index).Re_Out_Degrees<length(tmp_Node_Set)
    L_Node_Set=tmp_Node_Set(1:Node(WorkNode_Index).Re_Out_Degrees);
else
    L_Node_Set=tmp_Node_Set;
end
%step3.2
R_Node_Set=setdiff(Node_Set,union(X_Node_Set,L_Node_Set));
%step3.3
D_bar_der=D_bar;
if ~isempty(L_Node_Set)
    if ~isempty(setdiff(L_Node_Set,L_Node_Set(end)))
        for i=1:length(L_Node_Set)-1
            D_bar_der(L_Node_Set(i),1)=D_bar_der(L_Node_Set(i),1)-1;
        end
    end
end
D_bar_der(WorkNode_Index,2)=1;
%step3.4
D_bar_der=sortrows(D_bar_der,-1);
WorkNode_NewIndex=find(D_bar_der(:,3)==WorkNode_Index);
%step3.5
index=0;
if WorkNode_NewIndex==1
    for k=2:N
            L=sum(D_bar_der(1:k,1));
            R=0;
            for s=1:N
                if s<=k
                    R=R+min([k-1 D_bar_der(s,2)]);
                elseif s>k
                    R=R+min([k D_bar_der(s,2)]);
                end
            end
            if (L==R)
                index=1;
                break
            end
    end
    if index==0
        A_Node_Set=setdiff(D_bar_der(:,3),X_Node_Set);
    end
elseif WorkNode_NewIndex~=1
    for k=1:N
        L=sum(D_bar_der(1:k,1));
        R=0;
        for s=1:N
            if s<=k
                R=R+min([k-1 D_bar_der(s,2)]);
            elseif s>k
                R=R+min([k D_bar_der(s,2)]);
            end
        end
        if (L==R)
            index=1;
            break
        end
    end
    if index==0
        A_Node_Set=setdiff(D_bar_der(:,3),X_Node_Set);
    end
end
%step3.6
if isempty(A_Node_Set)
    if k==N
        A_Node_Set=setdiff(D_bar_der(:,3),X_Node_Set);
    else
        for i=k+1:N
            if ismember(D_bar_der(i,3),R_Node_Set)
                break
            end
        end
        %step3.7
        tmp_Index=find(D_bar(:,3)==D_bar_der(i,3));
        A_Node_Set=setdiff(D_bar(1:tmp_Index-1,3),X_Node_Set);
    end
end

end

