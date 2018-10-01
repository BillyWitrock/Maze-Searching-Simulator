%
% binary_maze.m
% Creates random maze via Binary Maze Algorithm
%
% Last Modified: 4/19/2018
% Modified By: Andrew Roberts
%

function [maze] = binary_maze(dim1, dim2)
    n = dim1 * dim2; 
    maze = eye(n); 
    
    for i = 1:n
        % Right wall
        if (mod(i, dim2) == 0) 
            if i ~= n
                maze(i, i+dim2) = 1; 
            end
            
            if i ~= dim2
                maze(i, i-dim2) = 1; 
            end
        elseif i > n - dim2 % Bottom wall
            if i ~= n
                maze(i, i+1) = 1; 
            end
            
            if i ~= n-dim2+1
                maze(i, i-1) = 1; 
            end
        else % Internal Walls
            if rand() > .5
                maze(i, i+1) = 1; 
                maze(i+1, i) = 1; 
            else
                maze(i, i+dim2) = 1; 
                maze(i+dim2, i) = 1; 
            end
        end
    end
   
 end
   

