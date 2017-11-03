% File Name: carv.m
% Author: Shashank Garg
% Date: October 29th, 2017

function [Ic, T] = carv(I, nr, nc,mask)
% Input:
%   I is the image being resized
%   [nr, nc] is the numbers of rows and columns to remove.
% 
% Output: 
% Ic is the resized image
% T is the transport map

% Write Your Code Here
    tic
    I=im2double(I);
    T=zeros(nr+1,nc+1);
    T1=zeros(nr+1,nc+1);
    im={};
    masks={};
    im{1,1}=I;
    masks{1,1}=mask;
    for j=2:nc+1
        e=genEngMap(im{1,j-1});
        m=masks{1,j-1};
        e=e.*m;
        [Mx,Tbx]=cumMinEngVer(e);
        [Ix,E,coord]=rmVerSeam(im{1,j-1},Mx,Tbx);
        im{1,j}=Ix;
        masks{1,j}=removeMaskVer(m,coord);
        T(1,j)=T(1,j-1)+E;
        T1(1,j)=-1;
    end
    
%    -1 for left, 1 for right
    
    for i=2:nr+1
        e=genEngMap(im{i-1,1});
        m=masks{i-1,1};
        e=e.*m;
        [My,Tby]=cumMinEngHor(e);
        [Iy,E,coord]=rmHorSeam(im{i-1,1},My,Tby);
        im{i,1}=Iy;
        masks{i,1}=removeMaskHor(m,coord);
        T(i,1)=T(i-1,1)+E;
        T1(i,1)=1;
    end
    
    for i=2:nr+1
        for j=2:nc+1
            
            if i-2>0
                im{i-2,j}=[];
                masks{i-2,j}=[];
            end
            el=genEngMap(im{i,j-1});
            ml=masks{i,j-1};
            el=el.*ml;
            [Mx,Tbx]=cumMinEngVer(el);
            [Ix,El,coordl]=rmVerSeam(im{i,j-1},Mx,Tbx);
            
            et=genEngMap(im{i-1,j});
            mt=masks{i-1,j};
            et=et.*mt;
            [My,Tby]=cumMinEngHor(et);
            [Iy,Et,coordt]=rmHorSeam(im{i-1,j},My,Tby);
            
            if T(i,j-1)+El<T(i-1,j)+Et
                im{i,j}=Ix;
                masks{i,j}=removeMaskVer(ml,coordl);
                T(i,j)=T(i,j-1)+El;
                T1(i,j)=-1;
            else
                im{i,j}=Iy;
                masks{i,j}=removeMaskHor(mt,coordt);
                T(i,j)=T(i-1,j)+Et;
                T1(i,j)=1;
            end
            
        end
    end
    
    %Ic=im;
    Ic=im{nr+1,nc+1};
    toc
end