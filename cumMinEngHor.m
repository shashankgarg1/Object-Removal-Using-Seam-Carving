% File Name: cumMinEngHor.m
% Author: Shashank Garg
% Date: October 25, 2017

function [My, Tby] = cumMinEngHor(e)
% Input:
%   e is the energy map.

% Output:
%   My is the cumulative minimum energy map along horizontal direction.
%   Tby is the backtrack table along horizontal direction.

% Write Your Code Here
    [nr,nc]=size(e);
   
    e_pad=padarray(e,[1,0],inf,'both');
    
    My=zeros(nr,nc);
    Tby=zeros(nr,nc);
    
    My=padarray(My,[1,0],inf,'both');
    Tby=padarray(Tby,[1,0],inf,'both');
    
    My(2:nr+1,1)=e(:,1);
    [nr_pad,nc_pad]=size(My);
    
    for j=2:nc_pad
        for i=2:nr_pad-1
            if My(i-1,j-1)<My(i,j-1) && My(i-1,j-1)<My(i+1,j-1)
                min_val=My(i-1,j-1);
                index=1;
            elseif My(i,j-1)<My(i-1,j-1) && My(i,j-1)<My(i+1,j-1)
                min_val=My(i,j-1);
                index=2;
            else
                min_val=My(i+1,j-1);
                index=3;
            end
            %min_arr=[My(i-1,j-1),My(i,j-1),My(i+1,j-1)];
            %[min_val,index]=min(min_arr);
            index=index-2;
            My(i,j)=e_pad(i,j)+min_val;
            Tby(i,j)=index;
        end
    end
    
    My=My(2:nr+1,:);
    Tby=Tby(2:nr+1,:);
end