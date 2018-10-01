function [found, location] = is_found(searchers, lost)
% returns true if the lost person is found
% returns false if the person has not been found yet
% By Billy Witrock

found = false;
% -1 impossible location if not found
location = -1;
for i = 1:size(searchers,2)
    if searchers(i).location == lost.location
        found = true;
        location = lost.location;
    end
end