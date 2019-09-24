%--------------------------------------------------------------------------
% Method_Pseudospectral.m
% Attempt to solve the Bryson-Denham problem using a pseudospectral method
% (namely LGL nodes and Gaussian quadrature) 
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% https://github.com/danielrherber/optimal-control-direct-method-examples
%--------------------------------------------------------------------------
function Method_Pseudospectral
    % problem parameters
    p.ns = 2; p.nu = 1; % number of states and controls
    p.t0 = 0; p.tf = 1; % time horizon
    p.y10 = 0; p.y1f = 0; p.y20 = 1; p.y2f = -1; % boundary conditions
    p.l = 1/9;
    % direct transcription parameters
    p.nt = 10; % number of node points
    % p.nt = 50; % number of node points
    p.tau = LGL_nodes(p.nt-1); % scaled time horizon
    p.D =  LGL_Dmatrix(p.tau); % for defect constraints
    p.w = LGL_weights(p.tau); % for gaussian quadrature
    % discretized variable indices in x = [y1,y2,u];
    p.y1i = 1:p.nt; p.y2i = p.nt+1:2*p.nt; p.ui = 2*p.nt+1:3*p.nt;
    x0 = zeros(p.nt*(p.ns+p.nu),1); % initial guess (all zeros)
    options = optimoptions(@fmincon,'display','iter','MaxFunEvals',1e5); % options
    % solve the problem
    x = fmincon(@(x) objective(x,p),x0,[],[],[],[],[],[],@(x) constraints(x,p),options);
    % obtain the optimal solution
    y1 = x(p.y1i); y2 = x(p.y2i); u = x(p.ui); % extract
    p.t = (p.tau*(p.tf-p.t0) + (p.tf+p.t0))/2; % unscale time horizon
    % plots
    Plots(y1,y2,u,p,'Pseudospectral')
end
% objective function
function f = objective(x,p)
    u = x(p.ui); % extract
    L = u.^2; % integrand
    f = (p.tf-p.t0)/2*dot(p.w,L)/2; % calculate objective
end
% constraint function
function [c,ceq] = constraints(x,p)
    y1 = x(p.y1i); y2 = x(p.y2i); u = x(p.ui); % extract
    Y = [y1,y2]; F = (p.tf-p.t0)/2*[y2,u]; % create matrices (p.nt x p.ns)
    ceq1 = y1(1) - p.y10; % initial state conditions
    ceq2 = y2(1) - p.y20;
    ceq3 = y1(end) - p.y1f; % final state conditions
    ceq4 = y2(end) - p.y2f;
    ceq5 = p.D*Y - F; % defect constraints matrix form (pseudospectral)
    c1 = y1 - p.l; % path constraints
    c = c1; ceq = [ceq1;ceq2;ceq3;ceq4;ceq5(:)]; % combine constraints
end