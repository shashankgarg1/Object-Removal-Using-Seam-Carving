function [im]=reconstructHorizontal(I,coords)
	no_of_coords=size(coords,1);
	[nr,nc,~]=size(I);
	im=zeros(nr+1,nc,3);
	assert(no_of_coords==nc);
	for j=1:no_of_coords
%		[x,y]=coords(j,:);
        x=coords(j,1);
        y=coords(j,2);
		assert(y==j);
		X=I(:,j,:);
        X=permute(X,[2,1,3]);
        %j,x
		if(x==1)
			z=[X(1,1,:)/2,X];
		elseif(x==nr+1)
			z=[X,X(1,nr,:)/2];
		else
			z=[X(1,1:x-1,:),(X(1,x-1,:)+X(1,x,:))/2,X(1,x:end,:)];
		end
		im(:,j,:)=permute(z,[2,1,3]);
	end
end