function mask=removeMaskVer(m,coords)
    [nr,nc]=size(m);
    mask=zeros(nr,nc-1);
    
    for i=1:size(coords,1)
        x=coords(i,1);
        y=coords(i,2);
        z=m(x,:);
        z(y)=[];
        mask(x,:)=z;
    end
end