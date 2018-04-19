
function [root, fx, ea, iter]=falsePosition(func, xl, xu, es, maxiter)
% The false position algorithm is used to evaluate the roots of the
% function to a certain desired error. The function should be inserted
% using symbolic variables. The inputs, xl and xu (lower and upper guess) should have the same unit
% and f(xl) and f(xu) should have opposite signs. The error (es) should be
% input as a percent and the maxiter is unitless. The user must input
% values for func, xl, xu, and has the option of inserting values for es
% and maxiter.
% 
% inputs:
%   func= the function being evaluated
%   xl= the lower guess
%   xu= the upper guess
%   es= the desired relative error (default= 0.0001%)
%   maxiter= the number of iterations desired (default= 200)
% outputs:
%   root= the estimated root location
%   fx= the function evaluated at the root location
%   ea= the approximate relative error (%)
%   iter= how many iterations were performed

if nargin <3 % only two of the input variables have default values, so at least three must be inputed
    error('At least 3 inputs required')
end
test=func(xl)*func(xu); % makes sure the bounds are actually around the root and not on the same side of the root
if test>0
    error('no sign change') % if they are on the same side, it will throw an error
end
if nargin <4 || isempty(es) % if there are only three input values, es=0.0001 and maxiter=200
    es=0.0001;
end
if nargin <5 || isempty(maxiter) % if there are only four input values, maxiter=200
    maxiter=200;
end
iter=0; % iter is 0 at the beginning because there have been no iterations
xr=xl; % set the root to be the lower guess
ea=100; % error is 100% because the root is set to one of the guessing bounds
while (1) % will run until a break because (1) signifies true
    xrold=xr; % the xr value will be set as the old xr value so a new one can be calculated
    xr=xu-((double(func(xu))*(xl-xu))/(double(func(xl))-double(func(xu)))); % calculates the false position function
    iter=iter+1; % adds 1 to the number of iterations each time the while loop runs
    if xr~=0 % the root is not zero
        ea=double(abs((xr-xrold)/xr)*100); % 'double function' is used to put in floating point form; calculates the percent error of the estimated root
    end
    test=double(func(xl)*func(xr)); % will test if the lower bound and new root have opposite signs
    if test<0 
        xu=xr; % if the value is negaitve, the estimated root will then be the new upper bound
    elseif test>0
        xl=xr; % if the value is positive, the estimated root will then be the new lower bound
    else
        ea=0; % otherwise, the error will be zero and the root has been found
    end
    if ea<=es || iter>=maxiter % if the percent error is less than the desired relative error or the maximum number of iterations has been met
        break % the while loop will be exited
    end
end
root=double(xr); % the root will be stored as the floating point number form of the most recent estimated root
fx=double(func(xr)); % fx will be stored as the floating point number form of the estimated root


