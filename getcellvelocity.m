function cellObj=getcellvelocity(cellObj,imBgSub)
% This function calculates the cell entry velocity, which is the average
% velocities of cell center through right half of image.
% @param   - cellObj, imBgSub
% @return  - cellObj
% @author  - Yiming Kang
% @version - 03.29.2014

for i=1:length(cellObj)
    tmpVelList=zeros(1,length(cellObj{i}.PixelIdxList)-1);
    for j=1:length(cellObj{i}.PixelIdxList)
        [tmpListX,tmpListY]=ind2sub(size(imBgSub),cellObj{i}.PixelIdxList{j});
        cellObj{i}.CellCenterList{j}=[mean(tmpListX),mean(tmpListY)];
        if (j~=1)
            tmpVelList(j-1)=pdist([cellObj{i}.CellCenterList{j}(1),cellObj{i}.CellCenterList{j}(2);...
                cellObj{i}.CellCenterList{j-1}(1),cellObj{i}.CellCenterList{j-1}(2)]);
        end
    end
    cellObj{i}.EntryVelocity=mean(tmpVelList);
end

