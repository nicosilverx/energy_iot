A = read_workload("workloads/wl_uniform_low.txt");
A_tmp = compute_regression(A,4999);

function A_tmp = compute_regression(workload, right_limit)
    x = 1:1:right_limit;
    A_sub = workload(2,1:right_limit)-workload(1,1:right_limit);
    
    A_tmp = zeros(1, right_limit);
    A_tmp(1,1)=0;
    A_tmp(1, 2:end)=A_sub(1, 1:end-1);
    
    [p,S] = polyfit(A_tmp, A_sub, 2);
    y = polyval(p,x);
    plot(x, y)
end

function A = read_workload(file_path)
    fileID = fopen(file_path, 'r');
    tline = fgetl(fileID);
    values = [2 Inf];
    formatSpec = '%d %d';
    
    A = fscanf(fileID, formatSpec, values);
    
    fclose(fileID);
end