close all; clear; clc;

% import and crop tif image stack
im=importtif('Stack1.tif');
frames=size(im,3);
im=im(15:32,49:96,:);

% preproce image stakc and identify cell object in each frame
tStart=tic;
[imBgSub,imBinary,cellFrame,cellObj]=getcellobj(im,frames);

% identify cell focal plane
cellObj=getcellfocal(imBgSub,cellObj);
for i=1:length(cellObj)
    if (cellObj{i}.FocalPlane==1)
        fprintf('Starting frame number of cell # %d is %d\n',i,cellObj{i}.StartingFrame);
    end
end
tElapsed=toc(tStart);
fprintf('\nPrimary objective processing time is %0.3f sec\n\n',tElapsed);

% calculate entry velocity
cellObj=getcellvelocity(cellObj,imBgSub);
for i=1:length(cellObj)
    fprintf('Entry velocity of cell # %d is %0.3f px/frame\n',i,cellObj{i}.EntryVelocity);
end

% show histrogram difference of cell focal planes
frameFP1=[3,15,33,291,344,366];
frameFP2=[86,102,149,208,258,378];
showCellHist(imBgSub,cellFrame,frameFP1,frameFP2);


