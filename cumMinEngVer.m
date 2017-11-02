% File Name: cumMinEngVer.m
% Author: Shashank Garg
% Date: October 25,2017

function [Mx, Tbx] = cumMinEngVer(e)
% Input:
%   e is the energy map

% Output:
%   Mx is the cumulative minimum energy map along vertical direction.
%   Tbx is the backtrack table along vertical direction.

% Write Your Code Here
    [nr,nc]=size(e);
    e_pad=padarray(e,[0,1],inf,'both');
    
    Mx=zeros(nr,nc);
    Tbx=zeros(nr,nc);
    
    Mx=padarray(Mx,[0,1],inf,'both');
    Tbx=padarray(Tbx,[0,1],inf,'both');
    
    Mx(1,2:nc+1)=e(1,:);
    [nr_pad,nc_pad]=size(Mx);
    
    for i=2:nr_pad
        for j=2:nc_pad-1
            if Mx(i-1,j-1)<Mx(i-1,j) && Mx(i-1,j-1)<Mx(i-1,j+1)
                min_val=Mx(i-1,j-1);
                index=1;
            elseif Mx(i-1,j)<Mx(i-1,j-1) && Mx(i-1,j)<Mx(i-1,j+1)
                min_val=Mx(i-1,j);
                index=2;
            else
                min_val=Mx(i-1,j+1);
                index=3;
            end
            %min_arr=[Mx(i-1,j-1),Mx(i-1,j),Mx(i-1,j+1)];
            %[min_val,index]=min(min_arr);
            index=index-2;
            Mx(i,j)=e_pad(i,j)+min_val;
            Tbx(i,j)=index;
        end
    end
    
    Mx=Mx(:,2:nc+1);
    Tbx=Tbx(:,2:nc+1);
end