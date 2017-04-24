function fig = createFigure(ax, x, y, fig)
    % createFigure fast plotting
    % fig = createFigure(ax, x, y) plots vector y versus vector x. It 
    % creates a new figure structure and returns it to its caller. 
    %
    % createFigure(ax, x, y, fig) plots vector y versus vector x. It takes
    % in the axes and figure structure which is returned on the first
    % function call. 
    
    
    
    
    % Function args num
    makeNew = nargin < 4; % number of arguments with out figure handle
    
    if(makeNew)
        % Create figure
        fig.title = ax.Title.String;
        fig.ylabel = ax.YLabel.String;
        fig.xlabel = ax.XLabel.String;
        if(~isempty(ax.Legend))
            fig.legend = ax.Legend.String;
        else
            fig.legend = '';
        end
        fig.h = plot(ax, x, y);
        title(ax, fig.title);
        ylabel(ax, fig.ylabel);
        xlabel(ax, fig.xlabel);
        
%         max_x = max(x(:));
%         max_y = max(y(:));
%         min_x = min(x(:));
%         min_y = min(y(:));
%         
%         ySpacer = max_y*0.05;
%         xSpacer = max_x*0.05;
%         max_comb= max([max_x, max_y]);
%         if(max_comb<=0) 
%             max_comb = 1;
%         end
        %ax.YLim = [-max_comb, max_comb] + ySpacer.*[-1,1];
        %ax.XLim = [min_x, max_x] + xSpacer.*[-1,1];
    
    else
        % Update figure
        fig.h.XData = x;
        fig.h.YData = y;
        drawnow limitrate
        
    end
    
    %ylabel(ax, fig.ylabel);
    %xlabel(ax, fig.xlabel);
    
end