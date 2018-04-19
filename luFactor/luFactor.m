function [L, U, P]=luFactor(A)
% The luFactor algorithm is used to determine the LU Factorization of a
% square matrix. The matrix inputed must be a square matrix. There can only
% be one input and it must be a matrix. 
%
% Input:
%   A= a square matrix
% Outputs:
%   L= lower triangular matrix
%   U= upper triangular matrix
%   P= the pivot matrix

if nargin~=1 
    error('Exactly one input required') % there must be only one input into the funtion
end
[n,m]=size(A); % considers the size of the inputed matrix
if n~=m
    error('Square matrix required') % if the number of rows and columns of the inputed matrix are not equal, an error will be thrown
end
L=eye(n); % creates an identity matrix, the size of the inputed matrix
P=eye(n); % creates a second identity matrix to be the original pivot matrix
if A(2,1)~=0 % checks that the position is not alreay a zero
    if abs(A(1,1))>abs((A(2,1)) && abs(A(3,1))) % does not pivot if the top row value has the largest absolute value
    else
        if (abs(A(2,1)))>(abs(A(1,1))) && (abs(A(2,1))>(abs(A(3,1)))) % if the second row value is the biggest of the three columns
            A2old=A(2,:); % stores the old second row in a variable that can be referenced later
            A(2,:)=A(1,:); % switches the first row to the second row
            A(1,:)=A2old; % switches the old second row to the first row
            P1old=P(1,:); % stores the old first row in a variable that can be referenced later
            P(1,:)=P(2,:); % switches the second row to the first row of the P matrix
            P(2,:)=P1old; % switches the old first row to the second row
        elseif (abs(A(3,1))>abs(A(1,1))) && (abs(A(3,1))>abs(A(2,1))) % if the third row value is the biggest of the three columns
            A3old=A(3,:); % stores the old third row in a variable that can be referenced later
            A(3,:)=A(1,:); % switches the first row to the third row
            A(1,:)=A3old; % switches the old third row to the first row
            P1old=P(1,:); % stores the old first row in a variable that can be referenced later
            P(1,:)=P(3,:); % switches the third row to the first row of the P matrix
            P(3,:)=P1old; % switches the old first row to the third row
        end
    end
    a21_a11=(A(2,1))/(A(1,1)); % conversion factor that will make A(2,1) be zero
    A(2,:)=(-(a21_a11)*A(1,:))+A(2,:); % makes the A(2,1) value zero
    L(2,1)=a21_a11; % stores the conversion factor in the L matrix
end
if A(3,1)~=0 % checks that the position is not alreay a zero
    a31_a11=(A(3,1))/(A(1,1)); % conversion factor that will make A(3,1) be zero
    A(3,:)=-(a31_a11)*A(1,:)+A(3,:); % makes the A(3,1) value zero
    L(3,1)=a31_a11; % stores the conversion factor in the L matrix
end
if A(3,2)~=0 % checks that the position is not alreay a zero
    if abs(A(2,2))>abs(A(3,2)) % does not pivot if A(2,2) has a larger absolute value than A(3,2)
    else
        if abs(A(3,2))>abs(A(2,2)) % if the third row value is bigger than the second row value
            A3old=A(3,:); % stores the old third row in a variable that can be referenced later
            A(3,:)=A(2,:); % switches the second row to the third row
            A(2,:)=A3old; % switches the old third row to the second row
            P2old=P(2,:); % stores the old second row in a variable that can be referenced later
            P(2,:)=P(3,:); % switches the third row to the second row of the P matrix
            P(3,:)=P2old; % switches the old second row to the third row
        end
    end
    a32_a22=(A(3,2))/(A(2,2)); % conversion factor that will make A(3,2) be zero
    A(3,:)=(-(a32_a22)*A(2,:))+A(3,:); % makes the A(3,2) value zero
    L(3,2)=a32_a22; % stores the conversion factor in the L matrix
end
L=L;
U=A;
P=P;