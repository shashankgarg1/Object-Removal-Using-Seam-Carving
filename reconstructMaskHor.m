function mask=reconstructMaskHor(m,coords)
    [nr,nc]=size(m);
    mask=m;
%    mask=ones(nr+1,nc);
    
    for i=1:size(coords,1)
        x=coords(i,1);
        y=coords(i,2);
        if x>1
            mask(x-1,y)=1000;
        end
        mask(x,y)=1000;
        if x<nr
            mask(x+1,y)=1000;
        end
    end
    
    mask=[mask;ones(1,size(mask,2))];
end