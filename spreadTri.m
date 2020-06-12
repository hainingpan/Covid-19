function param=spreadTri(param)
x=1:param.N;
current=~isinf(param.infection);
infected_lin=find(current);
infected_coor=param.r(infected_lin,:);
infected_x=infected_coor(:,1);
infected_y=infected_coor(:,2);
current_tmp=current;
parfor i=1:length(infected_lin)
    distance=sqrt((param.r(:,1)'-infected_x(i)).^2+(param.r(:,2)'-infected_y(i)).^2);
    probmat=param.prob(distance);    
    infection_rand=rand(1,param.N);
    immunity_rand=rand(1,param.N);
    current_tmp=(infection_rand<=probmat)&logical(param.agent)&(immunity_rand>param.immunity)|current_tmp;
end
newly=logical(current_tmp-current);
param.infection=(param.infection-1);
param.infection(newly)=param.lt;
param.newinfection=[param.newinfection,nnz(newly)];
end