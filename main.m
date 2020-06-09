function parameters=main(varargin)
p=inputParser;
addParameter(p,'L',100);   %length of square lattice
addParameter(p,'n',0.5);    %population density
addParameter(p,'k',2);      %power of prob of the infection
addParameter(p,'infection_prob',1); %instrinsic infection prob
addParameter(p,'lt',10);     %lifetime
addParameter(p,'p',0.05);   %fatality
addParameter(p,'immunity_prob',1);   %1:perfect immunity; 0: no immunity
parse(p,varargin{:});
parameters=struct('L',p.Results.L,'n',p.Results.n,'k',p.Results.k,'lt',p.Results.lt,'p',p.Results.p,...
    'infection_prob',p.Results.infection_prob,'immunity_prob',p.Results.immunity_prob);
parameters.prob=@(x) parameters.infection_prob./x.^parameters.k;
parameters.agent=(rand(parameters.L)<parameters.n);
parameters.infection=inf*ones(parameters.L); %inf: health 1~lt: infected 0:judge
agentlist=find(parameters.agent);
patient0=randi(length(agentlist));
parameters.infection(agentlist(patient0))=parameters.lt;
parameters.immunity=zeros(parameters.L);
parameters.kill=0;
parameters.recovery=0;
end