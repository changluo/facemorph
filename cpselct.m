%select feature points by hand
A = imread('child1.jpg');
B = imread('child2.jpg');
A = rgb2gray(A);
B =rgb2gray(B);

[m,n]=size(A);

iptsetpref('ImshowBorder','tight');
H = cpselect(A(:,:),B);











