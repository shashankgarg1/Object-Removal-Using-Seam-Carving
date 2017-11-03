function im_cell=getImages(I,T,mask, I1,T1,mask1)
    assert(size(T,1)==size(T1,1));
    assert(size(T,2)==size(T1,2));
    Im=im2double(I);
    %Im=t;
    [nr,nc]=size(T);
    T=padarray(T,[1,1],inf,'post');
    im_cell={};
    masks={};
    coord=[];
    len=1;
    r=1;
    c=1;
    coords={};
    directions=[];
    direction=0;
    while 1
        im_cell{len}=Im;
        masks{len}=mask;
        coords{len}=coord;
        directions=[directions,direction];
        len=len+1;
        if r==nr && c==nc
            break;
        end
        if T(r,c+1)<T(r+1,c)
            e=genEngMap(Im);
            e=e.*mask;
            [Mx,Tbx]=cumMinEngVer(e);
            [Im,E,coord]=rmVerSeam(Im,Mx,Tbx);
            mask=removeMaskVer(mask,coord);
            c=c+1;
            direction=-1;
        else
            e=genEngMap(Im);
            e=e.*mask;
            [My,Tby]=cumMinEngHor(e);
            [Im,E,coord]=rmHorSeam(Im,My,Tby);
            mask=removeMaskHor(mask,coord);
            r=r+1;
            direction=1;
        end
    end
    
    
    Im=im2double(I1);
    %Im=t;
    [nr,nc]=size(T1);
    T=padarray(T1,[1,1],inf,'post');
%    im_cell1={};
%    coord=[];
%    len1=1;
    r=1;
    c=1;
    mask=mask1;
%    coords={};
    directions=[];
    direction=0;
    while 1
        im_cell{len}=Im;
        masks{len}=masks;
        coords{len}=coord;
        directions=[directions,direction];
        len=len+1;
        if r==nr && c==nc
            break;
        end
        if T(r,c+1)<T(r+1,c)
            e=genEngMap(Im);
            e=e.*mask;
            [Mx,Tbx]=cumMinEngVer(e);
            [Im,E,coord]=reconstructVertical(Im,Mx,Tbx);
            mask=reconstructMaskVer(mask,coord);
            c=c+1;
            direction=-1;
        else
            e=genEngMap(Im);
            e=e.*mask;
            [My,Tby]=cumMinEngHor(e);
            [Im,E,coord]=reconstructHorizontal(Im,My,Tby);
            mask=reconstructMaskHor(mask,coord);
            r=r+1;
            direction=1;
        end
    end
    
%     n={};
%     j=1;
%     n{j}=im_cell{len-1};
%     for i=len-1:-1:2
%         j=j+1;
%         coord=coords{i};
%         if directions(i)==-1
%             n{j}=reconstructVertical(n{j-1},coord);
%         else
%             n{j}=reconstructHorizontal(n{j-1},coord);
%         end
%     end
%     
%     for i=1:j
%         im_cell{len}=n{i};
%         len=len+1;
%     end
    
    [nr,nc,~]=size(I);
    for i=1:len-1
        [rm,cm,~]=size(im_cell{i});
        im_cell{i}=padarray(im_cell{i},[nr-rm,nc-cm],255,'post');
    end
end