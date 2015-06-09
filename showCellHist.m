function showCellHist(imBgSub,cellFrame,frameFP1,frameFP2)
% This function demonstrates histogram differences of cell pixel intensity
% in different focal planes.
% @param   - imBgSub,cellFrame,frameFP1,frameFP2
% @author  - Yiming Kang
% @version - 03.29.2014

figure;
for i=1:6
    subplot(4,6,i);imagesc(imBgSub(:,:,frameFP1(i)));
    xlabel(['frame # ',num2str(frameFP1(i))]);axis image;axis off;
    
    tmp=imBgSub(:,:,frameFP1(i));
    tmp=tmp(cellFrame{frameFP1(i)}{1});
    subplot(4,6,i+6);hist(tmp,10,-40:40);
    xlabel(['frame # ',num2str(frameFP1(i))]); 
    xlim([-40,40]); ylim([0 40]);
    
    subplot(4,6,i+12);imagesc(imBgSub(:,:,frameFP2(i)));
    xlabel(['frame # ',num2str(frameFP1(i))]);axis image;axis off;

    tmp=imBgSub(:,:,frameFP2(i));
    tmp=tmp(cellFrame{frameFP2(i)}{1});
    subplot(4,6,i+18);hist(tmp,10,-40:40);
    xlabel(['frame # ',num2str(frameFP2(i))]); 
    xlim([-40,40]); ylim([0 40]);
end