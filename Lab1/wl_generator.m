%
% Lab1 : Generate workloads with different distributions
%

% Active periods have always uniform distribution
active_periods = randi([1 500], 1, 5000);

% Uniform idle period
high_uniform_idle_periods = randi([1 100], 1, 5000);
low_uniform_idle_periods = randi([1 400], 1, 5000);

generate_workload('wl_uniform_high.txt', active_periods, uniform_idle_periods);
generate_workload('wl_uniform_low.txt', active_periods, low_uniform_idle_periods);



function x = generate_workload(file_path, active, idle)
    fileID = fopen(file_path, 'w');
    global_time = 0;
    
    for i = 1:length(active)
        global_time = global_time + active(1,i);
        fprintf(fileID, '%i ', global_time);

        global_time = global_time + idle(1,i);
        fprintf(fileID, '%i\n', global_time);
    end
    
    fclose(fileID);
    x = 1;
end