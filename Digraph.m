function [ T,Node ] = Digraph(N,x_min,gamma,g0)
D=zeros(N,3);
% D(:,1:2)=[2 2;2 1;1 3;1 1;1 0];
while 1
    while 1
        D(:,1)=round(gprnd(gamma,0.1,x_min,N,1));
        D(:,2)=round(gprnd(gamma,0.1,x_min,N,1));
    
%         D(:,1)=binornd(N,3.5/N,N,1);
%         D(:,2)=binornd(N,3.5/N,N,1);
        if min(min((D(:,1:2)<N-1)))
            break
        end
    end
    D=sortrows(D,-2);
    D=sortrows(D,-1);
    L=zeros(N-1,1);
    R=zeros(N-1,1);
    for k=1:N-1
        L(k)=sum(D(1:k,1));
        for s=1:N
            if s<=k
                R(k)=R(k)+min([k-1 D(s,2)]);
            elseif s>k
                R(k)=R(k)+min([k D(s,2)]);
            end
        end
    end
    if (sum(L>R)+~(sum(D(:,1))==sum(D(:,2)))==0)
        break
    end
end
D(:,3)=1:1:N;
[Node,ZeroIn_Node_Set]=intial_digraph(D,N);
tmp_ZeroIn_Node_Set=ZeroIn_Node_Set;
%initially D_bar=D
D_bar=D;
while sum(D_bar(:,2))~=0
    D_bar=sortrows(D_bar,-2);
    D_bar=sortrows(D_bar,-1);
    %step1:find the work-node
    Index=0;
    while 1
        Index=Index+1;
        if D_bar(Index,2)>0
            break
        end
    end
    WorkNode_Index=D_bar(Index,3);
    %step2
    X_Node_Set=WorkNode_Index;
    if ~isempty(Node(WorkNode_Index).TargetNode_Set)
        X_Node_Set=union(X_Node_Set,Node(WorkNode_Index).TargetNode_Set);
    end
    X_Node_Set=union(X_Node_Set,tmp_ZeroIn_Node_Set);
    %step6
    while Node(WorkNode_Index).Re_Out_Degrees>0
        D_bar=sortrows(D_bar,-2);
        D_bar=sortrows(D_bar,-1);
        Index=find(D_bar(:,3)==WorkNode_Index);
        %step3
        A_Node_Set=A_Node_Set_Fun(N,D_bar,WorkNode_Index,X_Node_Set,Node);
        if isempty(A_Node_Set)
            D_bar=D;
            [Node,ZeroIn_Node_Set]=intial_digraph(D,N);
            tmp_ZeroIn_Node_Set=ZeroIn_Node_Set;
            break
        end
        %step4
        m=randi(length(A_Node_Set));
        m_Node_Index=A_Node_Set(m);
        Node(WorkNode_Index).Re_Out_Degrees=Node(WorkNode_Index).Re_Out_Degrees-1;
        D_bar(Index,2)=D_bar(Index,2)-1;
        Node(WorkNode_Index).TargetNode_Set=union(Node(WorkNode_Index).TargetNode_Set,m_Node_Index);
        Node(m_Node_Index).Re_In_Degrees=Node(m_Node_Index).Re_In_Degrees-1;
        tmp_Index=find(D_bar(:,3)==m_Node_Index);
        D_bar(tmp_Index,1)=D_bar(tmp_Index,1)-1;
        if Node(m_Node_Index).Re_In_Degrees==0
            tmp_ZeroIn_Node_Set=union(tmp_ZeroIn_Node_Set,Node(m_Node_Index).Index);
        end
        %step5
        X_Node_Set=union(X_Node_Set,m_Node_Index);
    end
end

T=zeros(N,N);
for i=1:N
    for j=1:length(Node(i).TargetNode_Set)
        T(i,Node(i).TargetNode_Set(j))=1;
    end
end

%G(:,1):the set of sources;G(:,2):the set of target nodes
G=[];
j=0;
for i=1:N
    tmp_length=length(Node(i).TargetNode_Set);
    if tmp_length~=0
        for k=1:tmp_length
            j=j+1;
            G(j,1)=Node(i).Index;
            G(j,2)=Node(i).TargetNode_Set(k);
        end
    end
end
g=figure('Name','Show the Graph of the network');
Graph=digraph(G(:,1),G(:,2));
plot(Graph)
pause(0.000001);
end





