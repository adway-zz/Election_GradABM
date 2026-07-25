for i=1:1000
a1=gamrnd(2,1);
a2=gamrnd(2,1);
a3=gamrnd(2,1);
alpha(i,:)=[a1 a2 a3]/(a1+a2+a3);
beta1(i)=0.5+0.5*rand;
beta2(i)=0.5+0.5*rand;
beta3(i)=0.5+0.5*rand;
[CC{i} V(i,:)]=PCM_batch(100*10000,100,10,alpha(i,:),[beta1(i) beta2(i) beta3(i)]);
end

for i=1:1000
X=CC{i};
N=sum(sum(X));
[S K]=size(X);
[Wtrue{i}, W{i}, V{i}, VV{i}, VV2{i}]=survey_fixed(X,sum(sum(X)),S,K,5,100,10);
end

k=0;
for i=1:1000
for j=1:5
k=k+1;
CC0{k}=VV2{i}{j};
alpha0(k,:)=alpha(i,:);
beta10(k)=beta1(i);
beta20(k)=beta2(i);
beta30(k)=beta3(i);
theta0(k,:)=theta(i,:);
end
end

load("/MATLAB Drive/indiasurveys_100_10.mat")
CC1=CC0;
for j=1:6
k=length(CC1);
for i=1:500
k=k+1;
CC1{k}=CC{j}{i};
end
end

alpha1=alpha0;
for j=1:6
k=size(alpha1,1);
aa=alpha(j,:);
al=repmat(aa,500,1);
alpha1=[alpha1;al];
end

CC=CC1;
alpha=alpha1;
beta1=beta10;
beta2=beta20;
beta3=beta30;
theta=theta0;

save indiasurveys_aug_PCM.mat CC alpha beta1 beta2 beta3 theta