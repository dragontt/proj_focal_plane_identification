function im=importtif(filename)
% This function imports tiff image stacks into Matlab matrix.
% @param   - filename
% @return  - im
% @author  - Yiming Kang
% @version - 03.29.2014

infoim=imfinfo(filename);
him=infoim(1).Width;
wim=infoim(1).Height;
fim=length(infoim);
chim=3;

if (strcmp(infoim(1).PhotometricInterpretation,'BlackIsZero')==1) 
    im=NaN(wim,him,fim);
    for k=1:fim
        im(:,:,k)=imread(filename,'Index',k);
    end
    
elseif strcmp(infoim(1).PhotometricInterpretation,'RGB') == 1
    im=NaN(wim,him,fim,chim);
    for k=1:fim
        im(:,:,k,:)=imread(filename,k,'Info',infoim);
    end
else
    fprintf('Unexpected TIF image color type');
end
