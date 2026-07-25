function [Wtrue, W, V, VV, VV2] = survey_fixed(X,N,S,K,niter,nV,nS)

Wtrue=zeros(niter,K);
W=zeros(niter,K); 
V=zeros(niter,K);

for k=1:niter 
    VV{k}=zeros(S,K);
    VV2{k}=zeros(nS,K);
    ss=randsample(1:S,nS);  
    for i=1:length(ss)
        s=ss(i); 
        pp=X(s,:); 
        pp=pp/sum(pp); 
        w=mnrnd(nV,pp); 
        V(k,:)=V(k,:)+w; 
        VV{k}(s,:)=w; 
        VV2{k}(i,:)=w;
    end
    j=find(w==max(w)); 
    if (length(j)>1) j=randsample(j,1);
    end
    W(k,j)=W(k,j)+1;
end
XX=X(ss,:);
for s=1:length(ss)
    j=find(XX(s,:)==max(XX(s,:)));
    Wtrue(k,j)=Wtrue(k,j)+1;
end
end