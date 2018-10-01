classdef Person < handle
    % person: This is to represent a single person in a maze
    % By Billy Witrock other modified versons not posted by Adam Rayfield
    % and Andrew Roberts
    
    properties
        location % current location of person in maze
        visited  % list of places node visited
    end
    
    methods
        
        % constructor
        % start could be 'r' for random, 's' for start, or 'c' for center
        %   defaults to random
        % size is size of maze
        function obj = Person(start, size)            
            switch start 
                case 'r'
                    obj.location = floor(rand() * size) + 1;
                case 's'
                    obj.location = 1;
                case 'c'
                    obj.location = round(size/ 2);
                otherwise
                    fprintf("Error!, start invalid\n");
                    obj.location = floor(rand() * size) + 1;
            end
            
            obj.visited = [obj.location];
        end
        
        % moves to any connected spot with equal probablity
        % returns the location of the person after the move
        function moved = move(obj, maze)

            trans_vector = maze(obj.location,:);
            % random number 1 - number of places could move
            random = floor(rand() * sum(trans_vector,2) + 1);
            
            % finds the place where it is going to move
            for i = 1:size(trans_vector,2)
                if trans_vector(i) ~= 0
                    random = random - 1;
                    if random == 0
                        obj.location = i;
                        moved = i;
                        obj.visited = [obj.visited,i];
                        return
                    end
                end
            end
                         
        end
        
    end
end

