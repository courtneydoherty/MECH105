function [I]=Simpson(x,y)
% This algorithm is used to determine the integral of a set of experimental
% data using the Simpson's 1/3 rule. The function checks if there are an
% odd number of intervals, and if so, the trapezoidal rule is used for the
% last interval. The x and y inserted arrays must be equal in length for
% the function to run. The user must insert both x and y values.
% 
% inputs:
%   x= column matrix of x variables
%   y= column matrix of y variables
% output:
%   I= the intergral of the vector of function values 'y' with respect to 'x'

if nargin~=2 %two column matrices must be inserted into the fucntion
    error('must insert values x and y into the function')
end
if length(x)~=length(y) %the length of the two inserted matrices must have the same number of rows
    error('inputed arrays must be the same size')
end
if linspace(x(1,1),x(end,1),length(x))' ~= x %the values in the x matrix must be evenly spaced
    error('the x inputs must be equally spaced')
end

N=length(x); %number of points in the x matrix
if mod((length(x)-1),2) ~=0 %checks to see if the are an odd number of intervals
    warning('the trapezoidal rule will be used for the last interval') %if there are an odd number of intervals, the trapezoidal rule will be used on the last interval
end

if mod((length(x)-1),2)==0 %if there are an even number of intervals, only the simpson's 1/3 rule will be used
    I=(x((end-1),1)-x(1,1))*((y(1,1)+4*sum(y(2:2:(end-1)))+2*sum(y(3:2:(end-2)))+y(end,1))/(3*(N-2))); %determines the integral using the simpson's 1/3 rule for all of the intervals
elseif mod((length(x)-1),2) ~=0 %if there are an odd number of intervals, the simpson's 1/3 sule and the trapezoidal rule will be used
    I=(x((end-1),1)-x(1,1))*((y(1,1)+4*sum(y(2:2:(end-1)))+2*sum(y(3:2:(end-2)))+y((end-1),1))/(3*(N-2))); %determines the integral for all of the intervals but the last one, using the simpson's 1/3 rule
    I_last=(x(end,1)-x((end-1),1))*((y(end,1)+y((end-1),1))/2); %determines the integral between the last interval by using the trapezoidal rule
    I=I+I_last; %combines the intergral calculated but the simpson's 1/3 rule and the integral determined by the trapezoidal rule
end



    


