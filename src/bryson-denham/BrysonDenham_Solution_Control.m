%--------------------------------------------------------------------------
% BrysonDenham_Solution_Control.m
% Calculates the optimal control for the Bryson-Denham problem
%--------------------------------------------------------------------------
% Valid when 0 < l <= 1/6
% See pages 120–123 of A. E. Bryson and Y.-C. Ho, Applied Optimal Control, 
% revised printing ed. Taylor & Francis, 1975.
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% https://github.com/danielrherber/optimal-control-direct-method-examples
%--------------------------------------------------------------------------
function U = BrysonDenham_Solution_Control(t,l)

    U = zeros(length(t),1);

    %----------------------------------------------------------------------
    if (l > 0) && (l <= 1/6)
        for i = 1:length(t)
            if (t(i) <= 3*l)
                u = -2/(3*l)*(1-t(i)/(3*l));
            elseif (t(i) >= 1-3*l)
                u = -2/(3*l)*(1 - (1-t(i))/(3*l));
            else
                u = 0;
            end
            % create the control matrix
            U(i,:) = u;
        end
    %----------------------------------------------------------------------
    elseif (l >= 1/6) && (l <= 1/4)
        for i = 1:length(t)
            if (t(i) <= 1/2)
                u = -8*(1-3*l) + 24*(1-4*l)*t(i);
            else
                u = -8*(1-3*l) + 24*(1-4*l)*(1-t(i));
            end
            % create the control matrix
            U(i,:) = u;
        end
    %----------------------------------------------------------------------
    elseif (l >= 1/4)
        for i = 1:length(t)
            u = -2;
            % create the control matrix
            U(i,:) = u;
        end
    %----------------------------------------------------------------------
    else
        U = nan(length(t),1);
    end
    
end