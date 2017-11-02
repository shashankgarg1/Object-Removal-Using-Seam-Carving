% File Name: rmHorSeam.m
% Author:
% Date:

function [Iy, E,coord] = rmHorSeam(I, My, Tby)
% Input:
%   I is the image. Note that I could be color or grayscale image.
%   My is the cumulative minimum energy map along horizontal direction.
%   Tby is the backtrack table along horizontal direction.

% Output:
%   Iy is the image removed one row.
%   E is the cost of seam removal

% Write Your Code Here
    [nr,nc]=size(My);
    %I=im2double(I);
    
    [E,index]=min(My(:,nc));
    coord=[];
    for j=nc:-1:1
        I(index,j,:)=-1;
        coord=[coord;index,j];
        index=index+Tby(index,j);
    end
    coord=flip(coord,1);
    Iy=zeros(nr-1,nc,3);
    
    for j=1:nc
        for k=1:3
            x=I(:,j,k);
%            x=[x;0];
            x(x==-1)=[];
            Iy(:,j,k)=x;
        end
    end
    
end