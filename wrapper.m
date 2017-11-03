clear
clc
I=imread('3.jpg');
%I=imresize(I,0.8);
mask=maskImage(I);
q=double(mask);
ind=find(q==1);
s=size(q);
[R,C]=ind2sub(s,ind);
%q=q.*(-exp(5));
q=q.*(-1000);
%q(isnan(q))=1;
q(q==0)=1;

mask=maskImage(I);
f=double(mask);
f=f.*(1000);
f(f==0)=1;

q=q.*f;
%t=repmat(q,1,1,3);
%I=im2double(I);
%w=I.*t;
%w=im2uint8(w);
nr=(max(R)-min(R)+1);
nc=(max(C)-min(C)+1);
[Ic,T]=carv(I,0,nc,q);
%[Ic,T]=carv(I,0,max(C)-min(C)+1,q);
%T1=T;
%video_creator2
t=ones(size(Ic,1),size(Ic,2));
[Ic1, T1] = insertion(Ic, 0, nc,t);
m=getImages(I,T,q,Ic,T1,t);
video_creator
imwrite(Ic1,'3oh_test.jpg');