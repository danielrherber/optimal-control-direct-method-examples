function Method_SingleStep
    % problem parameters
    p.ns = 2; p.nu = 1; % number of states and controls
    p.t0 = 0; p.tf = 1; % time horizon
    p.y0 = 0; p.yf = 0; p.v0 = 1; p.vf = -1; % boundary conditions
    p.l = 1/9;
    % direct transcription parameters
    p.nt = 50; % number of node points
    p.t = linspace(p.t0,p.tf,p.nt)'; % time horizon
    p.h = diff(p.t); % step size
    % discretized variable indices in x = [y,v,u];
    p.yi = 1:p.nt; p.vi = p.nt+1:2*p.nt; p.ui = 2*p.nt+1:3*p.nt;
    x0 = zeros(p.nt*(p.ns+p.nu),1); % initial guess (all zeros)
    options = optimoptions(@fmincon,'display','iter','MaxFunctionEvaluations',1e5); % options
    % solve the problem
    x = fmincon(@(x) objective(x,p),x0,[],[],[],[],[],[],@(x) constraints(x,p),options);
    % obtain the optimal solution
    y = x(p.yi); v = x(p.vi); u = x(p.ui); % extract
    % plots
    plots(y,v,u,p)
end
% objective function
function f = objective(x,p)
    u = x(p.ui); % extract
    L = u.^2/2; % integrand
    f = trapz(p.t,L); % calculate objective
end
% constraint function
function [c,ceq] = constraints(x,p)
    y = x(p.yi); v = x(p.vi); u = x(p.ui); % extract
    Xi = [y,v]; F = [v,u]; % create matrices (p.nt x p.ns)
    ceq1 = y(1) - p.y0; % initial state conditions
    ceq2 = v(1) - p.v0;
    ceq3 = y(end) - p.yf; % final state conditions
    ceq4 = v(end) - p.vf;
    % defect constraints
    ceq5 = Xi(2:p.nt,1) - Xi(1:p.nt-1,1) - p.h/2.*( F(1:p.nt-1,1) + F(2:p.nt,1) );
    ceq6 = Xi(2:p.nt,2) - Xi(1:p.nt-1,2) - p.h/2.*( F(1:p.nt-1,2) + F(2:p.nt,2) );
    c1 = y - p.l; % path constraints
    c = c1; ceq = [ceq1;ceq2;ceq3;ceq4;ceq5;ceq6]; % combine constraints
end
% plotting function
function plots(y,v,u,p)
    close all
    % plot states
    figure
    plot(p.t,[y,v],'.'); xlabel('t'); ylabel('states'); hold on
    % plots control
    figure
    plot(p.t,u,'.'); xlabel('t'); ylabel('u'); hold on
end