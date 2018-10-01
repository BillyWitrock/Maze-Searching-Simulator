function [step_list, impact_locations] = monte_carlo_num_searchers...
                                (n_itr, maze_size,num_searchers,maze_type)
    %
    % Monte Carlo simulation: Binary maze, 1 searcher, random starting 
    %                         positions, no exits
    % By: Andrew Roberts, slightly modified by Billy Witrock
    %       other modifed verison not post 
    %
    % Inputs: 
    %       n_itr: Number of iterations in Monte Carlo simulation
    %       maze_size: Number of nodes in maze
    %
    % Outputs:
    %       step_list: Vector containing number of steps taken until impact
    %                  for each iteration; dimension: 1 x n_itr
    %       impact_locations: Vector containing counts of impact locations
    %                         for each node; dimension: 1 x maze_size;
    %                         E.g. impact_locations(1) is the count of
    %                         impacts that occurred on the first node
    %

    impact_locations = zeros(1, maze_size); 
    step_list = zeros(1, n_itr);
    
    for i = 1:n_itr
        [n_steps, loc_impact, path_hist] = maze_simulation(maze_type,...
                                                num_searchers, maze_size);
        
        impact_locations(loc_impact) = impact_locations(loc_impact) + 1; 
        step_list(i) = n_steps;  
    end

end