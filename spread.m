function param=spread(param)
x=1:param.L;
[X,Y]=meshgrid(x,x);
current=~isinf(param.infection);
infected_lin=find(current);
[infected_x,infected_y]=ind2sub([param.L,param.L],infected_lin);
current_tmp=current;
for i=1:length(infected_lin)
    distance=sqrt((Y-infected_x(i)).^2+(X-infected_y(i)).^2);
    probmat=param.prob(distance);    
    infection_rand=rand(param.L);
    immunity_rand=rand(param.L);
    current_tmp=(infection_rand<=probmat)&logical(param.agent)&(immunity_rand>param.immunity)|current_tmp;
end
newly=logical(current_tmp-current);
param.infection=(param.infection-1);
param.infection(newly)=param.lt;
end