function [k1,k2,k3,a] = affine(x, y, xO, yO, xP, yP, xQ, yQ)
 
 xO = repmat(xO, size(x,1), size(x,2));       
 yO = repmat(yO, size(x,1), size(x,2));       
 xP = repmat(xP, size(x,1), size(x,2));
 yP = repmat(yP, size(x,1), size(x,2));
 xQ = repmat(xQ, size(x,1), size(x,2));
 yQ = repmat(yQ, size(x,1), size(x,2));
 
 %affine algorithm 
 k1 = ((x-xQ).*(yP-yQ) - (y-yQ).*(xP-xQ))./ ((xO-xQ).*(yP-yQ) - (yO-yQ).*(xP-xQ));      
 k2 = ((x-xQ).*(yO-yQ) - (y-yQ).*(xO-xQ))./ ((xP-xQ).*(yO-yQ) - (yP-yQ).*(xO-xQ));
 k3 = 1 - k1 - k2;
 %set the irrelevent points zero
 a = (k1>=0) & (k2>=0) & (k3>=0) & (k1<=1) & (k2<=1) & (k3<=1);
 k1(~a)=0;
 k2(~a)=0;
 k3(~a)=0;
 
end