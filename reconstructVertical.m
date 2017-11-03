function [im]=reconstructVertical(I,coords)
	no_of_coords=size(coords,1);
	[nr,nc,~]=size(I);
	im=zeros(nr,nc+1,3);
	assert(no_of_coords==nr);
	for i=1:no_of_coords
%		[x,y]=coords(i,:);
        x=coords(i,1);
        y=coords(i,2);
		assert(x==i);
		X=I(i,:,:);
		if(y==1)
			z=[X(1,1,:)/2,X];
		elseif(y==nc+1)
			z=[X,X(1,nc,:)/2];
		else
			z=[X(1,1:y-1,:),(X(1,y-1,:)+X(1,y,:))/2,X(1,y:end,:)];
		end
		im(i,:,:)=z;
	end
end