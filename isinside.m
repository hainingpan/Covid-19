function inside=isinside(n,L)
%Check oneNote schematic
%1 if inside 
W=L*sqrt(3);
outside=(n(:,2)>=n(:,1)+1)...
    +(n(:,2)<=-n(:,1)-1)...
    +(n(:,2)>=-n(:,1)+2*L)...
    +(n(:,2)<=n(:,1)-2*W);
inside=((outside)==0);
end