clc;
clear all;
%load the feature points of image A and B
load child  
%load image A
A = imread('child2.jpg');
height = size(A,1);               %height of image A
width = size(A,2);                %width of image B

figure
imshow(A);
%extract x and y axis values of image A feature points
xA = child.basePoints(:,1);
yA = child.basePoints(:,2);
%add the corner point 
xA = [xA;1;width;width;1];
yA = [yA;1;1;height;height];    

%load image B
B = imread('child1.jpg');
figure
imshow(B);
%extract x and y axis values of image A feature points
xB = child.inputPoints(:,1);       
yB =child.inputPoints(:,2);  
%add the corner point 
xB = [xB;1;width;width;1];         
yB = [yB;1;1;height;height];    

%%initilize the video
%aviobj =avifile('test.avi');
%%loop of the increment alpha 
%for alpha=0.1:0.005:0.9
%set the alpha
alpha=0.4;

%the objective feature points value,using cross-dissolve
xC = alpha*xA + (1-alpha)*xB;
yC = alpha*yA + (1-alpha)*yB;
%Delaunay triangulation 
triC = delaunay(xC,yC);        
nTri = size(triC,1);        %number of triangular
%initialize matrix with ones
xCA = zeros(height,width);
yCA = zeros(height,width);
xCB = zeros(height,width);
yCB = zeros(height,width);

[X,Y] = meshgrid(1:width,1:height);   
%for each triangular 
for i = 1:nTri
	[k1,k2,k3,a] = affine(X, Y, xC(triC(i,1)), yC(triC(i,1)), xC(triC(i,2)),...
        yC(triC(i,2)), xC(triC(i,3)), yC(triC(i,3)));
	
	xCA = xCA + k1.*xA(triC(i,1)) + k2.*xA(triC(i,2)) + k3.*xA(triC(i,3));
	yCA = yCA + k1.*yA(triC(i,1)) + k2.*yA(triC(i,2)) + k3.*yA(triC(i,3));
	xCB = xCB + k1.*xB(triC(i,1)) + k2.*xB(triC(i,2)) + k3.*xB(triC(i,3));
	yCB = yCB + k1.*yB(triC(i,1)) + k2.*yB(triC(i,2)) + k3.*yB(triC(i,3));
end
%Interpolation for 2-D gridded data in meshgrid forma
CA(:,:,1) = interp2(X,Y,double(A(:,:,1)),xCA,yCA);     
CA(:,:,2) = interp2(X,Y,double(A(:,:,2)),xCA,yCA);
CA(:,:,3) = interp2(X,Y,double(A(:,:,3)),xCA,yCA);

CB(:,:,1) = interp2(X,Y,double(B(:,:,1)),xCB,yCB);
CB(:,:,2) = interp2(X,Y,double(B(:,:,2)),xCB,yCB);
CB(:,:,3) = interp2(X,Y,double(B(:,:,3)),xCB,yCB);

% cross-dissolve to composite two image to objective 
C = alpha*CA+(1-alpha)*CB;     
C = uint8(C);
figure
imshow(C);

%%plot the triaugular lines and points with image C
% hold on
% triplot(triC,xC,yC);
% hold on;
% plot(xC,yC,'bo');
% hold on;
% triplot(triC,xA,yA,'r');
% hold on
% plot(xA,yA,'r*');
% hold off
%%get each frame of video
% F=getframe(gcf);
%%add frame F to video
% aviobj =addframe(aviobj,F);
% 
% end
%%close the avi obj 
% aviobj =close(aviobj);