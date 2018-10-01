function [num_steps_mean, num_steps_median,locations, num_steps_std, num_in_std]...
    =  maze_sim_diff_searchers(n_iter, maze_size, alpha, maze_type)
%Maze_sim_diff_searchers runs the maze simulator multiple times with
%   different number of searchers until the differernce is less than 
%   alpha percent
%
% returns number of steps and the locations of where the impact is 
% each row is the set of single data
%
%   By Billy Witrock

%get first two number of searchers
[step_list_1,impact_1] = monte_carlo_num_searchers(n_iter, maze_size,...
                                                        1, maze_type);
mean_1 = mean(step_list_1);                                                    
num_steps_mean = [mean_1];
num_steps_median = [median(step_list_1)];

 %std
count_of_no_outliers = 0;
for i = 1:n_iter
    if(~isoutlier(step_list_1(i),'quartiles'))
        count_of_no_outliers = count_of_no_outliers + 1;
    end
end
step_list_outliers = zeros(1,count_of_no_outliers);
j = 1;
for i = 1:n_iter
    if(~isoutlier(step_list_1(i),'quartiles'))
        step_list_outliers(j) = step_list_1(i);
        j = j + 1;
    end
end
num_steps_std = [mean(step_list_outliers)];
num_in_std = [count_of_no_outliers];



locations = [impact_1];

[step_list_2,impact_2] = monte_carlo_num_searchers(n_iter, maze_size,...
                                                        2, maze_type);
               
mean_2 = mean(step_list_2);                                                    
num_steps_mean = [num_steps_mean, mean_2];
num_steps_median = [num_steps_median, median(step_list_2)];
locations = [locations;impact_2];

 %std
count_of_no_outliers = 0;
for i = 1:n_iter
    if(~isoutlier(step_list_2(i),'quartiles'))
        count_of_no_outliers = count_of_no_outliers + 1;
    end
end
step_list_outliers = zeros(1,count_of_no_outliers);
j = 1;
for i = 1:n_iter
    if(~isoutlier(step_list_2(i),'quartiles'))
        step_list_outliers(j) = step_list_2(i);
        j = j + 1;
    end
end
num_steps_std = [num_steps_std,mean(step_list_outliers)];
num_in_std = [num_in_std,count_of_no_outliers];


count = 2;
%while the percent difference is greater than alpha keep going
while((abs(num_steps_mean(count) - num_steps_mean(count - 1)) ./ num_steps_mean(count - 1))...
                                                                > alpha)
    count = count + 1;
    [step_list,impact] = monte_carlo_num_searchers(n_iter, maze_size,...
                                                      count,maze_type);
                                                
    num_steps_mean = [num_steps_mean, mean(step_list)];
    num_steps_median = [num_steps_median, median(step_list)];
    locations = [locations;impact];
    
    %std
    count_of_no_outliers = 0;
    for i = 1:n_iter
        if(~isoutlier(step_list(i),'quartiles'))
            count_of_no_outliers = count_of_no_outliers + 1;
        end
    end
    step_list_outliers = zeros(1,count_of_no_outliers);
    j = 1;
    for i = 1:n_iter
        if(~isoutlier(step_list(i),'quartiles'))
            step_list_outliers(j) = step_list(i);
            j = j + 1;
        end
    end
    num_steps_std = [num_steps_std,mean(step_list_outliers)];
    num_in_std = [num_in_std,count_of_no_outliers];
end

end

    
        
            
    
    




% 
%     %std stuff
%     standard_dev = std(step_list);
%     is_in = zeros(1,n_iter);
%     num_in = 0;
%     for i = 1:n_iter
%         if (step_list(i) <= mean_cur + 1.5 * standard_dev)
%             if(step_list(i) >= mean_cur - 1.5 * standard_dev)
%                 is_in(i) = 1;
%                 num_in = num_in + 1;
%             end
%         end
%     end
%     steps_std = zeros(1,num_in);
%     count_so_far = 1;
%     for i = 1:n_iter
%         if is_in(i) == 1
%             steps_std(count_so_far) = step_list(i);
%             count_so_far = count_so_far + 1;
%         end
%     end
%     num_steps_std = [num_steps_std ,mean(steps_std)];
%     num_in_std = [num_in_std, num_in];

