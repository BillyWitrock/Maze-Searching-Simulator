%
% gen_fully_connected_maze.m
% Generates fully connected maze represented as a graph/adjacency matrix
%
% Last Modified: 4/19/2018
% Modified By: Andrew Roberts
%

function [maze] = gen_fully_connected_maze(dim1, dim2)
    n = dim1 * dim2; 
    maze = zeros(n, n); 
    
     for i = 1:n
         % Self Connections
         maze(i, i) = 1; 
         
         % Vertical Connections
         if i > dim2
            maze(i, i-dim2) = 1; 
         end
         
         if i <= n-dim2
             maze(i, i+dim2) = 1; 
         end
         
         % Horizontal Connections
         if mod(i-1, dim2) ~= 0
             maze(i, i-1) = 1;
             maze(i-1, i) = 1; 
         end
         
         if mod(i, dim2) ~= 0
            maze(i, i+1) = 1; 
            maze(i+1, i) = 1; 
         end
     end
         
end
