%% make animated gif from all_stages
%
%
%

filename = "animated.gif"; % Specify the output file name
nImages = size(all_stages,3);
dt = 0.1;
for idx = 1:nImages
    A = 255*all_stages(:,:,idx);
    if idx == 1
        imwrite(A,filename,"gif",LoopCount=Inf, ...
                DelayTime=dt)
    else
        imwrite(A,filename,"gif",WriteMode="append", ...
                DelayTime=dt)
    end
end