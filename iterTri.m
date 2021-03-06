param=mainTri('immunity_prob',0.,'n',0.5,'ts',5);
clear infectionsav immunitysav killsav recoverysav
infectionsav(:,1)=param.infection;
immunitysav(:,1)=param.immunity;
killsav(1)=param.kill;
recoverysav(1)=param.recovery;

v = VideoWriter('sample');
v.FrameRate=10;
open(v);

figure('Units','normalized','Position',[0 0 1 1]);
% subplot(2,2,1);
% imagesc(param.agent);
% colorbar;
% title('Agent');
subplot(2,2,1);
scatter(param.r(:,1),param.r(:,2),[],param.immunity','.');
axis tight;
daspect([1,1,1]);
colorbar;
title(strcat('Immunity at time: 0'));
subplot(2,2,2);
scatter(param.r(:,1),param.r(:,2),[],param.infection','.');
axis tight;
daspect([1,1,1]);
colorbar;
title(strcat('Infection at time: 0'));

Ninfection=squeeze(sum(~isinf(infectionsav),1));
newinfection=[1,diff(Ninfection')];
newkill=[0,diff(killsav)];
newrecovery=[0,diff(recoverysav)];
subplot(2,2,3);
plot(1:length(Ninfection),newinfection,1:length(Ninfection),newkill,1:length(Ninfection),newrecovery)
title(strcat('time:0'));
legend(strcat("New infected: ",num2str(param.newinfection(end))),strcat("New death: ",num2str(newkill(end))),strcat("new recovery: ",num2str(newrecovery(end))),'location','northeast');

subplot(2,2,4);
plot(1:length(Ninfection),Ninfection);
title(strcat('Existing infected at time:0'));

drawnow;
i=0;
changed=0;
while (Ninfection>0) & i<10000
    i=i+1;
%spread
% if (Ninfection(end)>=0.1*nnz(param.agent)) & changed==0
%     changed=1;
%     param.ts=i;
%     param.k=5;
%     param.prob=@(x) param.infection_prob./(x+1).^param.k;
% end

if (i==param.ts)
    param.k=5;
    param.prob=@(x) param.infection_prob./(x+1).^param.k;
end

param=spreadTri(param);

% figure(figinf);
subplot(2,2,2)
scatter(param.r(:,1),param.r(:,2),[],param.infection','.');
axis tight;
daspect([1,1,1]);
colorbar;
caxis([0,10])
title(strcat('Infection at time:',num2str(i)));
infectionsav(:,i+1)=param.infection;
%kill
param=killTri(param);

% figure(figim);
subplot(2,2,1);
scatter(param.r(:,1),param.r(:,2),[],param.immunity','.');
axis tight;
daspect([1,1,1]);
colorbar;
caxis([0,1])
title(strcat('Immunity at time:',num2str(i)));
% figure(fignum);
immunitysav(:,i+1)=param.immunity;
killsav(i+1)=param.kill;
recoverysav(i+1)=param.recovery;

% Nimmunity=squeeze(sum(immunitysav,[1,2]));
Ninfection=squeeze(sum(~isinf(infectionsav),1));
newkill=[0,diff(killsav)];
newrecovery=[0,diff(recoverysav)];
subplot(2,2,3);
plot(1:length(Ninfection),param.newinfection,'r',1:length(Ninfection),newkill,'k',1:length(Ninfection),newrecovery,'b');
if (i<param.ts)
    title(strcat('time:',num2str(i)));
%     legend(strcat("Immuned: ",num2str(Nimmunity(end))),strcat("Infected: ",num2str(Ninfection(end))),strcat("Death: ",num2str(newkill(end))),strcat("Recovery: ",num2str(newrecovery(end))),'location','northwest');
    legend(strcat("New infected: ",num2str(param.newinfection(end))),strcat("New death: ",num2str(newkill(end))),strcat("new recovery: ",num2str(newrecovery(end))),'location','northeast');
else
    title(strcat('(Social distancing...) time:',num2str(i)));
    xline(param.ts,'--k');
%     legend(strcat("Immuned: ",num2str(Nimmunity(end))),strcat("Infected: ",num2str(Ninfection(end))),strcat("Death: ",num2str(newkill(end))),strcat("Recovery: ",num2str(newrecovery(end))),strcat('time since SD: ',num2str(i-param.ts)),'location','northwest');
    legend(strcat("New infected: ",num2str(param.newinfection(end))),strcat("New death: ",num2str(newkill(end))),strcat("New recovery: ",num2str(newrecovery(end))),strcat('time since SD: ',num2str(i-param.ts)),'location','northeast');
end
xlabel('Time')
xlim([max(1,length(Ninfection)-100),length(Ninfection)])

subplot(2,2,4);
plot(1:length(Ninfection),Ninfection);
title(strcat('Existing infected at time:0'));
if (i<param.ts)
    title(strcat('Existing infected: ',num2str(Ninfection(end)),', at time:',num2str(i)));
else
    title(strcat('(Social distancing...) Existing infected:',num2str(Ninfection(end)),', at time:',num2str(i)));
    xline(param.ts,'--k');
end
xlabel('Time');
xlim([1,length(Ninfection)]);

drawnow;
% mov(i+1) = getframe(gcf);
frame = getframe(gcf);
writeVideo(v,frame);
end

save('sample.mat','immunitysav','infectionsav','killsav','recoverysav');
close(v);
