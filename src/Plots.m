%--------------------------------------------------------------------------
% Method_Pseudospectral.m
% Plotting function
%--------------------------------------------------------------------------
%
%--------------------------------------------------------------------------
% Primary Contributor: Daniel R. Herber, Graduate Student, University of 
% Illinois at Urbana-Champaign
% https://github.com/danielrherber/optimal-control-direct-method-examples
%--------------------------------------------------------------------------
function Plots(y,v,u,p,method)
    %----------------------------------------------------------------------
    fontlabel = 20; % x,y label font size
    fontlegend = 12; % x,y legend font size
    fonttick = 12; % x,y rick font size
    wcolor = [1 1 1]; % white color
    bcolor = [0 0 0]; % black color
    mycolor = lines(8);
    
    set(0,'DefaultTextInterpreter','latex'); % change the text interpreter
    set(0,'DefaultLegendInterpreter','latex'); % change the legend interpreter
    set(0,'DefaultAxesTickLabelInterpreter','latex'); % change the tick interpreter
    
    T = linspace(p.t0,p.tf,10000);
    
    if strcmp(method,'Pseudospectral')
        yl = LagrangeInter(p.t',y',T); 
        vl = LagrangeInter(p.t',v',T);
        ul = LagrangeInter(p.t',u',T); 
    end
        
    %----------------------------------------------------------------------
    % plot states
    hf = figure; % create a new figure and save handle
    hf.Color = wcolor; % change the figure background color
 
    Xopt = BrysonDenham_Solution_States(T,p.l);
    plot(T,Xopt(:,1),'-','linewidth',2,'color',mycolor(6,:)); hold on
    plot(T,Xopt(:,2),'-','linewidth',2,'color',mycolor(2,:)); hold on
        
    plot(p.t,y,'.','markersize',14,'color',mycolor(1,:)); hold on
    plot(p.t,v,'.','markersize',14,'color',mycolor(7,:)); hold on
    
    if strcmp(method,'Pseudospectral')
        plot(T,yl,'-','color',mycolor(1,:)); hold on
        plot(T,vl,'-','color',mycolor(7,:)); hold on
    end
    
    mytitle = [method,' Method - States']; % title with latex
    myxlabel = '$t$'; % x label with latex
    myylabel = 'states'; % y label with latex
    mylegend = {'True Solution - State 1','True Solution - State 2',...
        [method, ' - State 1'],[method, ' - State 2']}; % legend with latex
    xlabel(myxlabel) % create x label
    ylabel(myylabel) % create y label
    ha = gca; % get current axis handle
    try
        ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark grey)
        ha.XAxis.FontSize = fonttick; % change x tick font size
        ha.YAxis.FontSize = fonttick; % change y tick font size
        ha.XAxis.Label.FontSize = fontlabel; % change x label font size
        ha.YAxis.Label.FontSize = fontlabel; % change y label font size
        ht = title(mytitle);
        ht.FontSize = fontlabel;
        hl = legend(mylegend,'location','Best'); % create legend
        hl.FontSize = fontlegend; % change legend font size
        hl.EdgeColor = bcolor; % change the legend border to black (not a dark grey)
    catch
        disp('plot formatting failed (try using a version that supports HG2)')
    end
    
    %----------------------------------------------------------------------
    % plots control
    hf = figure; % create a new figure and save handle
    hf.Color = wcolor; % change the figure background color
    
    Uopt = BrysonDenham_Solution_Control(T,p.l);
    plot(T,Uopt(:,1),'linewidth',1,'color',mycolor(6,:)); hold on
    
    plot(p.t,u,'.','markersize',14,'color',mycolor(1,:)); hold on

    if strcmp(method,'Pseudospectral')
        plot(T,ul,'-','color',mycolor(1,:)); hold on
    end
    
	mytitle = [method,' Method - Control']; % title with latex
    myxlabel = '$t$'; % x label with latex
    myylabel = 'control'; % y label with latex
    mylegend = {'True Solution - Control',[method, ' - Control']}; % legend with latex
    xlabel(myxlabel) % create x label
    ylabel(myylabel) % create y label
    try
        ha = gca; % get current axis handle
        ha.XAxis.Color = bcolor; % change the x axis color to black (not a dark grey)
        ha.XAxis.FontSize = fonttick; % change x tick font size
        ha.YAxis.FontSize = fonttick; % change y tick font size
        ha.XAxis.Label.FontSize = fontlabel; % change x label font size
        ha.YAxis.Label.FontSize = fontlabel; % change y label font size
        ht = title(mytitle);
        ht.FontSize = fontlabel;
        hl = legend(mylegend,'location','Best'); % create legend
        hl.FontSize = fontlegend; % change legend font size
        hl.EdgeColor = bcolor; % change the legend border to black (not a dark grey)
    catch
        disp('plot formatting failed (try using a version that supports HG2)')
    end
end