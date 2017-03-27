function Method_Pseudospectral
    % problem parameters
    p.ns = 2; p.nu = 1; % number of states and controls
    p.t0 = 0; p.tf = 1; % time horizon
    p.y0 = 0; p.yf = 0; p.v0 = 1; p.vf = -1; % boundary conditions
    p.l = 1/9;
    % direct transcription parameters
    p.nt = 50; % number of node points
    p.tau = LGL_nodes(p.nt-1); % scaled time horizon
    p.D =  LGL_Dmatrix(p.tau); % for defect constraints
    p.w = LGL_weights(p.tau); % for gaussian quadrature
    % discretized variable indices in x = [y,v,u];
    p.yi = 1:p.nt; p.vi = p.nt+1:2*p.nt; p.ui = 2*p.nt+1:3*p.nt;
    x0 = zeros(p.nt*(p.ns+p.nu),1); % initial guess (all zeros)
    options = optimoptions(@fmincon,'display','iter','MaxFunctionEvaluations',1e5); % options
    % solve the problem
    x = fmincon(@(x) objective(x,p),x0,[],[],[],[],[],[],@(x) constraints(x,p),options);
    % obtain the optimal solution
    y = x(p.yi); v = x(p.vi); u = x(p.ui); % extract
    p.t = (p.tau*(p.tf-p.t0) + (p.tf+p.t0))/2; % unscale time horizon
    % plots
    plots(y,v,u,p)
end
% objective function
function f = objective(x,p)
    u = x(p.ui); % extract
    L = u.^2; % integrand
    f = (p.tf-p.t0)/2*dot(p.w,L)/2; % calculate objective
end
% constraint function
function [c,ceq] = constraints(x,p)
    y = x(p.yi); v = x(p.vi); u = x(p.ui); % extract
    Xi = [y,v]; F = (p.tf-p.t0)/2*[v,u]; % create matrices (p.nt x p.ns)
    ceq1 = y(1) - p.y0; % initial state conditions
    ceq2 = v(1) - p.v0;
    ceq3 = y(end) - p.yf; % final state conditions
    ceq4 = v(end) - p.vf; 
    ceq5 = p.D*Xi - F; % defect constraints matrix form (pseudospectral)
    c1 = y - p.l; % path constraints
    c = c1; ceq = [ceq1;ceq2;ceq3;ceq4;ceq5(:)]; % combine constraints
end
% plotting function
function plots(y,v,u,p)
    close all
    p.tl = linspace(p.t0,p.tf,1000);
    yl = LagrangeInter(p.t',y',p.tl); 
    vl = LagrangeInter(p.t',v',p.tl);
    ul = LagrangeInter(p.t',u',p.tl); 
    % plot states
    figure
    plot(p.t,[y,v],'.'); xlabel('t'); ylabel('states'); hold on
    plot(p.tl,[yl;vl],'-');  hold on
    % plots control
    figure
    plot(p.t,u,'.'); xlabel('t'); ylabel('u'); hold on
    plot(p.tl,ul);  hold on
end