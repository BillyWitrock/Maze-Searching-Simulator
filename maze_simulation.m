function [num_steps, location, paths] = maze_simulation(maze_creation_type, ... 
                                                 num_searchers, maze_size)
% Maze_simulation: simulates finding a single person lost in a maze
%       By Billy Witrock other modified versons not posted done by 
%        Adam Rayfield and Andrew Roberts
%
% Note: To be found a searcher must be in the same spot as the lost person
%
%       Also, the searchers and lost person move at same time:
%           So, if the searcher moves from 2 to 3 and the lost person 
%           3 to 4, the person would not be found
%
%       Also, multiple searchers can be in the same place
%
% inputs:
%     maze_creation_type: 
%         'b' for binary algorithm 
%         'f' for fully_connected algorithm
%         defaults to binary
%     num_searchers: 
%         the number of people searching for the lost person in the maze
%     maze_size:
%         the number of nodes in the maze 
%         Must be a perfect square
%  returns:
%     num_steps: number of steps it took to find the lost person
%     location: the location of where the lost person was found
%     paths: the paths each person took. The top row is the lost person
%            then the following rows are the people looking

%blank returns just in case there is an error
num_steps = [];
location = [];
paths = [];

if num_searchers <= 0
    fprintf("Error: need at least one searchers\n");
    return;
end

% creates all the searchers
searchers = [];
for i = 1:num_searchers
    searchers = [searchers, Person('r',maze_size)];
end

lost = Person('r',maze_size);

% creates the maze based on the given algorithm
maze_dim = maze_size .^ (1/2);
maze = [];
switch maze_creation_type
    case 'f'
        maze = gen_fully_connected_maze(maze_dim,maze_dim);
    otherwise
        maze = binary_maze(maze_dim,maze_dim);
end
    
found = false;

%starts at -1 so the first loop makes the number of steps zero
num_steps = -1;
while ~found
    [found, location] = is_found(searchers,lost);
    num_steps = num_steps + 1;
    for i = 1:num_searchers
        move(searchers(i),maze);
    end
    move(lost,maze);
end

% sets path return variable
paths = zeros(1 + size(searchers,2),num_steps + 2);
paths(1,:) = lost.visited;
for i = 1:num_searchers
     paths(1 + i,:) = searchers(i).visited;
end

% elimanates the last column because it is the move after the person is
% found
paths(:,num_steps + 2) = [];

end




