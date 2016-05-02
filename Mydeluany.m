clc
clear all

%% plot the triangular using delaunay

A = imread('child1.jpg');
B = imread('child2.jpg');
% load feature points
load child
a=child.inputPoints;
b=child.basePoints;

%add corner points
cp=zeros(38,2);
cp=zeros(38,2);

cpA(:,1)=[a(:,1)',1,500,500,1];
cpA(:,2)=[a(:,2)',1,1,500,500];

cpB(:,1)=[b(:,1)',1,500,500,1];
cpB(:,2)=[b(:,2)',1,1,500,500];

a=zeros(38,2);
b=zeros(38,2);
a=cpA;
b=cpB;

imshow(A);
hold on
IRT = delaunay(a(:,1),a(:,2));
triplot(IRT,a(:,1),a(:,2));
hold on;
plot(a(:,1),a(:,2),'or');
hold on;
triplot(IRT,b(:,1),b(:,2),'m');
hold on
plot(b(:,1),b(:,2),'*');
hold off
figure;imshow(B);
hold on;
triplot(IRT,b(:,1),b(:,2));
hold on;
plot(b(:,1),b(:,2),'or');