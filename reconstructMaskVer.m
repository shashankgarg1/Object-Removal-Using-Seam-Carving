function mask=reconstructMaskVer(m,coords)
    [nr,nc]=size(m);
    mask=m;
    %mask=ones(nr,nc+1);
    
    for i=1:size(coords,1)
        x=coords(i,1);
        y=coords(i,2);
%         if y>1
%             mask(x,y-1)=1000;
%         end
        mask(x,y)=1000;
        if y<nc
            mask(x,y+1)=1000;
        end
    end
    
    mask=[mask,ones(size(mask,1),1)];
end