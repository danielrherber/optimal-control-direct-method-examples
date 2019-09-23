%--------------------------------------------------------------------------
% Method_DTQPProject.m
% Attempt to solve the Bryson-Denham problem using the methods in the DT QP
% Project (solves linear-quadratic dynamic optimization (LQDO) problems
% using direct transcription (DT) and quadratic programming (QP))
% Link: https://github.com/danielrherber/dt-qp-project
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% https://github.com/danielrherber/optimal-control-direct-method-examples
%--------------------------------------------------------------------------
function Method_DTQPProject
    % problem parameters
    p.y10 = 0; p.y1f = 0; p.y20 = 1; p.y2f = -1; % boundary conditions
    p.l = 1/9;
    % direct transcription parameters
    opts.dt.nt = 10; % number of node points
    method = 1;
    switch method
        case 1 % similar to Method_SingleStep.m
            opts.dt.mesh = 'ED'; % time grid method
            opts.dt.defects = 'TR'; % defect constraint method
            opts.dt.quadrature = 'CTR'; % quadrature method 
        case 2 % similar to Method_Pseudospectral.m
            opts.dt.mesh = 'LGL'; % time grid method
            opts.dt.defects = 'PS'; % defect constraint method
            opts.dt.quadrature = 'G'; % quadrature method
    end
    % time horizon
    setup.t0 = 0; setup.tf = 1; % time horizon
    % system dynamics
    A = [0 1;0 0]; B = [0;1];
    % Lagrange term
    L(1).left = 1; L(1).right = 1; L(1).matrix = 1/2; % 1/2*u^2
    % simple bounds
    UB(1).right = 4; UB(1).matrix = [p.y10;p.y20]; % initial states
    LB(1).right = 4; LB(1).matrix = [p.y10;p.y20];
    UB(2).right = 5; UB(2).matrix = [p.y1f;p.y2f]; % final states
    LB(2).right = 5; LB(2).matrix = [p.y1f;p.y2f];
    UB(3).right = 2; UB(3).matrix = [p.l;Inf]; % states
    % combine structures
    setup.A = A; setup.B = B; setup.L = L; setup.UB = UB; setup.LB = LB; setup.p = p;
    % solve the problem
    [~,U,Y,~,~,p,~] = DTQP_solve(setup,opts);
    % plots
    p.l = p.p.l;
    Plots(Y(:,1),Y(:,2),U,p,'DT QP Project')
end