%% Aero 306
% XFoil Project
% Gerard Boberg and Trevor Buck and Zane Paterson
%
% Adapted from Gerard's solution to hwk5, p1, which was
%   adapted from Dr. Marshall's given code, for his class
% 18 Nov 2014
%
function [ ux, uy ] = line_source_constant( lambda, x, y, xp, yp )
% Calculates the induced Velocity at a point from a constant strength
% source panel.
%
% ux = induced velocity in the x direction at the point (xp, yp)
% uy = induced velocity in the y direction at the point (xp, yp)
r1 = sqrt( (xp - x( 1 ) )^2 + ( yp - y( 1 ) )^2 );  % start line source to point
r2 = sqrt( (xp - x(end) )^2 + ( yp - y(end) )^2 );  % endof line source to point

% check for discontinuity when on the source. Prevents a ln(0) or ln( inf )
tollerance = 1e-7; % some small number
if ( r1 < tollerance )
    r1 = tollerance;
end
if ( r2 < tollerance )
    r2 = tollerance;
end
    

I1 = log( r1 / r2 ); % Integral one, across the line source

theta1 = atan2( (y(end)-y(1)), (x(end)-x(1)) );
beta1  = atan2( (yp-y( 1 ) ), ( xp-x( 1 ) ) ) - theta1; % between pi and -pi
beta2  = atan2( (yp-y(end) ), ( xp-x(end) ) ) - theta1; % between pi and -pi

I2 = beta2 - beta1; % potentially between 2pi and -2pi

% Bind the integral, I2, between -pi and pi
% Edge cases at B1 = +- pi, B2 = 0 && B1 = 0, B2 = +- pi
if     ( I2 < -pi )
    I2 = I2 + (2*pi);
elseif (I2 >  pi)
    I2 = I2 - (2*pi);
elseif ( abs(( abs(I2) - pi )) < tollerance )
    I2 = pi; 
end


u_zp = ( lambda / ( 2*pi ) ) * I1; % induced in zeta direction
u_np = ( lambda / ( 2*pi ) ) * I2; % induced in eta  direction

ux =  ( u_zp*cos(theta1) ) - ( (u_np)*sin(theta1) ); % convert to xy coords
uy =  ( u_zp*sin(theta1) ) + ( (u_np)*cos(theta1) ); 

end % End of File
