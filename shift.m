function nn=shift(n,L)
W=L*sqrt(3);
%Check oneNote schematic
shiftvector=(n(:,2)>=n(:,1)+1).*[W,-W]...
    +(n(:,2)<=-n(:,1)-1).*[L,L]...
    +(n(:,2)>=-n(:,1)+2*L).*[-L,-L]...
    +(n(:,2)<=n(:,1)-2*W).*[-W,W];
nn=n+shiftvector;
end