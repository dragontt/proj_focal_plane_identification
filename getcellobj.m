function [imBgSub,imBinary,cellFrame,cellObj]=getcellobj(im,frames)
% This function identifies cell object(s) from grayscale image.
% @param   - im, frames
% @return  - imBgSub, imBinary, cellFrame
% @author  - Yiming Kang
% @version - 03.29.2014

cellFrame=cell(1,frames);
imBgSub=zeros(size(im));
imBinary=imBgSub;
for i=1:frames
    % subtract background
    imBgSub(:,:,i)=im(:,:,i)-im(:,:,1);
    % thresholding
    tmpIm=zeros(size(imBgSub(:,:,i)));
    tmpIm(imBgSub(:,:,i)>5 | imBgSub(:,:,i)<-5)=1;
    % hole filling
    tmpIm=imfill(tmpIm,6,'holes');
    tmpIm=logical(tmpIm>0);
    % identifiy cell object
    tmpImcellFrame=bwconncomp(tmpIm,8);
    if (tmpImcellFrame.NumObjects>0)
        for j=1:tmpImcellFrame.NumObjects
            if (length(tmpImcellFrame.PixelIdxList{j})<50)
                tmpIm(tmpImcellFrame.PixelIdxList{j})=0;
                tmpImcellFrame.PixelIdxList{j}=[];
            end
        end
        cellFrame{i}=tmpImcellFrame.PixelIdxList(~cellfun('isempty',tmpImcellFrame.PixelIdxList));
    end
    imBinary(:,:,i)=tmpIm;
end

% sort out the cell object from frames
cellObj={};
for i=2:frames
    if (~isempty(cellFrame{i}))
        if (isempty(cellFrame{i-1}))
            cellObj=[cellObj,struct];
            cellObj{end}.PixelIdxList(1)=cellFrame{i};
            cellObj{end}.StartingFrame=i;
        elseif (~isempty(cellFrame{i-1}))
            cellObj{end}.PixelIdxList(end+1)=cellFrame{i};
        end
    end
end