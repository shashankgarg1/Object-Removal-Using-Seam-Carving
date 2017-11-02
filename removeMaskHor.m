function mask=removeMaskHor(m,coords)
    [nr,nc]=size(m);
    mask=zeros(nr-1,nc);
    
    for i=1:size(coords,1)
        x=coords(i,1);
        y=coords(i,2);
        z=m(:,y);
        z(x)=[];
        mask(:,y)=z;
    end
end