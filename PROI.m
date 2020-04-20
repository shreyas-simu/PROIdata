close all
clear all
clc
tic;
f = imread('5152.jpg'); %read the input image.
[nor, noc] = size(f);   %number of rows and cloumns of the image.   
row = zeros(1,noc);     %add a row of zeroes at the bottom of image.
I = cat(1,f,row);
        %Gaussian filtering to remove noise
G1 = fspecial('gaussian',3,5);
C1 = imfilter(double(I),G1,'replicate');
        %Multi-level otsu thresholding to get the boundary of hand.
level = round(multithresh(C1));
%Th = round(level*max(f(:)));
bin = mmthreshad(C1,level);
mmshow(bin);
        %Steps to smothen the boundary and remove unnecessary items. 
E = mmero(bin,mmsecross(3));        %morphological erosionclose all
mmshow(E);
%%
Clo = mmclohole(E,mmsecross(2));    %close holes function
Clo = mmedgeoff(Clo);               %removes objects at the edge of image.
Open = mmareaopen(Clo,150000);       %delete uncessary objects.
mmshow(Open);
        %Steps the extract the fingers of hand.
sk = mmskelm(Open);             %skeleton function 
Dsk = mmdil(sk,mmsedisk(3));    %dilate the skeleton
Opend = mmareaopen(Dsk,1000);   
thin = mmthin(Opend);
thin2 = mmthin(thin,mmendpoints,2); 
%figure, mmshow(Opend,thin2);
L = bwlabel(thin2);             %label all the skeletons.
%figure, mmlblshow(L);
% fr = mmlabel(L);
% box = mmblob(fr,'boundingbox');
region = regionprops(L,'all');  %find all the properties of labeled parts.
%figure, mmshow(mmdil(cent));
centroids = cat(1, region.Centroid);
BB = cat (1, region.BoundingBox);
Or = cat (1, region.Orientation);
AA = cat (1, region.Area);
[A, ai] = max(AA);
centroids(ai,:) = [];
[r , c] = size(centroids);
Dmc = zeros(r-1,1);
for i = 1:r-1
    for j = 1:c-1;
        p11 = centroids(i,j);
        p12 = centroids(i,j+1);
        p21 = centroids(i+1,j);
        p22 = centroids(i+1,j+1);
    end
    Dmc(i) = sqrt( (p21-p11)^2 + (p22-p12)^2 );
end
mdist = round(min(Dmc));
X1 = round((mdist/4) + (mdist/16));
X2 = round(2*X1);
X3 = round(4*X1);

for i = 1:size(Or)
    if Or(i)<0
        Or(i)=90+Or(i);
    else
        Or(i)=270+Or(i);
    end
    B = imrotate(I,-Or(i));
    C = imrotate(L,-Or(i));
    region2 = regionprops(C,'all');
    BB = cat (1, region2.BoundingBox);
    figure, mmshow(B,C);
    cr1 = rectangle('Position',[BB(i,1)-X1-0,BB(i,2)-X1-0,BB(i,3)+X2+0,BB(i,4)+X3+40]);
    X = imcrop(B,[BB(i,1)-X1-0 BB(i,2)-X1-0 BB(i,3)+X2+0 BB(i,4)+X3+40]);
    figure, mmshow(X);
    Z{i} = X;
end
toc;
%figure, mmshow(I,L);


%hold on
%plot(centroids(:,1), centroids(:,2), 'b*')
%rectangle('Position',[BB(1,1),BB(1,2),BB(1,3),BB(1,4)],...
%'EdgeColor','r','LineWidth',2)
%hold off

%cr2 = Drawbox(BB(2,1),BB(2,2),BB(2,3),BB(2,4),Or(2));
%cr4 = Drawbox(BB(4,1),BB(4,2),BB(4,3),BB(4,4),Or(4));
%cr6 = Drawbox(BB(6,1),BB(6,2),BB(6,3),BB(6,4),Or(6));
%cr7 = Drawbox(BB(7,1),BB(7,2),BB(7,3),BB(7,4),Or(7));
