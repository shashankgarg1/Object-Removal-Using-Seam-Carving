% File Name: rmVerSeam.m
% Author:
% Date:

function [Ix, E,coord] = rmVerSeam(I, Mx, Tbx)
% Input:
%   I is the image. Note that I could be color or grayscale image.
%   Mx is the cumulative minimum energy map along vertical direction.
%   Tbx is the backtrack table along vertical direction.

% Output:
%   Ix is the image removed one column.
%   E is the cost of seam removal

% Write Your Code Here
    [nr,nc]=size(Mx);
    %I=im2double(I);
    
    [E,index]=min(Mx(nr,:));
    coord=[];
    for i=nr:-1:1
        I(i,index,:)=-1;
        coord=[coord;i,index];
        index=index+Tbx(i,index);
    end
    coord=flip(coord,1);
    Ix=zeros(nr,nc-1,3);
    
    for i=1:nr
        for k=1:3
            x=I(i,:,k);
%            x=[x,0];
            x(x==-1)=[];
            Ix(i,:,k)=x;
        end
    end
    
end