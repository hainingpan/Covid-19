function parameters=mainTri(varargin)
p=inputParser;
addParameter(p,'L',53);   %length of square lattice
addParameter(p,'n',0.5);    %population density
addParameter(p,'k',2);      %power of prob of the infection
addParameter(p,'infection_prob',1); %instrinsic infection prob
addParameter(p,'lt',10);     %lifetime
addParameter(p,'p',0.05);   %fatality
addParameter(p,'immunity_prob',1);   %1:perfect immunity; 0: no immunity
addParameter(p,'ts',0);
parse(p,varargin{:});
parameters=struct('L',p.Results.L,'n',p.Results.n,'k',p.Results.k,'lt',p.Results.lt,'p',p.Results.p,...
    'infection_prob',p.Results.infection_prob,'immunity_prob',p.Results.immunity_prob,'ts',p.Results.ts);
parameters.prob=@(x) parameters.infection_prob./(x+1).^parameters.k;
L=parameters.L;
W=L*sqrt(3);
x=0:W+L;
y=-W:L;
[xgrid,ygrid]=meshgrid(x,y);
xline=xgrid(:);
yline=ygrid(:);
filter=isinside([xline,yline],L);
index=[xline(filter),yline(filter)];
N=size(index,1);
parameters.N=N;
parameters.index=index;
parameters.a1=[sqrt(3)/2,1/2];
parameters.a2=[sqrt(3)/2,-1/2];
a=[parameters.a1;parameters.a2];
parameters.r=index*a;

parameters.agent=(rand(1,N)<parameters.n);
parameters.infection=inf*ones(1,N);
agentlist=find(parameters.agent);
patient0=randi(length(agentlist));
parameters.infection(agentlist(patient0))=parameters.lt;
parameters.immunity=zeros(1,N);

parameters.kill=0;
parameters.recovery=0;
parameters.newinfection=1;
end