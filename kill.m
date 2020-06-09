function param=kill(param)
judge=~logical(param.infection);
judgelist=find(judge);
Nj=length(judgelist);
die=(rand(1,Nj)<=param.p);
recover=~die;
dieindex=(judgelist(die));
recoverindex=(judgelist(recover));
param.infection(judgelist)=Inf;
%if dies
param.immunity(dieindex)=0;
param.kill=param.kill+length(dieindex);
%if recovers
param.immunity(recoverindex)=param.immunity_prob;
param.recovery=param.recovery+length(recoverindex);
end