function cellObj=getcellfocal(imBgSub,cellObj)
% This function identifies cell focal plane based on histogram
% @param   - imageBgSub, cellObj
% @return  - cellObj
% @author  - Yiming Kang
% @version - 03.29.2014

for i=1:length(cellObj)
    listNegPct=length(cellObj{i}.PixelIdxList);
    for j=1:length(cellObj{i}.PixelIdxList)
        tmpIm=imBgSub(:,:,cellObj{i}.StartingFrame+j-1);
        tmpIm=tmpIm(cellObj{i}.PixelIdxList{j});
        listNegPct(j)=length(find(tmpIm<0))/length(cellObj{i}.PixelIdxList{j});
    end
    % according to different histogram patterns of cell obejcts, 0.64, the 
    % negative pixel intensity is choosen to draw relative line between 
    % cells in focal plane 1 and 2
    if (mean(listNegPct)<0.64)
        cellObj{i}.FocalPlane=1;
    else cellObj{i}.FocalPlane=2;
    end
end