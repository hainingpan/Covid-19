param=main('immunity_prob',0.5,'n',0.01);
clear infectionsav immunitysav killsav recoverysav
infectionsav(:,:,1)=param.infection;
immunitysav(:,:,1)=param.immunity;
killsav(1)=param.kill;
recoverysav(1)=param.recovery;

figure;subplot(2,2,1);
imagesc(param.agent);
colorbar;
title('Agent');
% figim=figure;
subplot(2,2,2);
imagesc(param.immunity);
colorbar;
title(strcat('Immunity at time:',num2str(i)));
% figinf=figure;
subplot(2,2,3);
imagesc(param.infection);
colorbar;
title(strcat('Infection at time:',num2str(i)));
Nimmunity=squeeze(sum(immunitysav,[1,2]));
Ninfection=squeeze(sum(infectionsav,[1,2]));
% fignum=figure;
subplot(2,2,4);
plot(1:length(Nimmunity),Nimmunity,1:length(Ninfection),Ninfection,1:length(Ninfection),[0,diff(killsav)],1:length(Ninfection),[0,diff(recoverysav)])
title(strcat('Current * at time:0'));
legend("Immuned","Infected","Death","Recovery",'location','northwest');
drawnow;

for i=1:200
%     disp(i);
%spread
param=spread(param);

% figure(figinf);
subplot(2,2,3)
imagesc(param.infection);
colorbar;
caxis([0,10])
title(strcat('Infection at time:',num2str(i)));
infectionsav(:,:,i+1)=param.infection;
%kill
param=kill(param);

% figure(figim);
subplot(2,2,2);
imagesc(param.immunity);
colorbar;
caxis([0,1])
title(strcat('Immunity at time:',num2str(i)));
% figure(fignum);
immunitysav(:,:,i+1)=param.immunity;
killsav(i+1)=param.kill;
recoverysav(i+1)=param.recovery;

Nimmunity=squeeze(sum(immunitysav,[1,2]));
Ninfection=squeeze(sum(~isinf(infectionsav),[1,2]));
subplot(2,2,4);
plot(1:length(Nimmunity),Nimmunity,1:length(Ninfection),Ninfection,1:length(Ninfection),[0,diff(killsav)],1:length(Ninfection),[0,diff(recoverysav)])
legend("Immuned","Infected","Death","Recovery",'location','northwest');
title(strcat('Current * at time:',num2str(i)));
xlabel('Time')
xlim([1,length(Nimmunity)]);
drawnow;
end

save('sample.mat','immunitysav','infectionsav','killsav','recoverysav');
