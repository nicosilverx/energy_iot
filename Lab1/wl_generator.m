%
% Lab1 : Generate workloads with different distributions
%

% Active periods have always uniform distribution

% Empty arrays for values
active_periods = zeros(1, 5000);
high_uniform_idle_periods = zeros(1, 5000);
low_uniform_idle_periods = zeros(1, 5000);

% Empty arrays for frequencies
freq_active_periods = zeros(1, 500);
freq_high_uniform_idle_periods = zeros(1, 100);
freq_low_uniform_idle_periods = zeros(1, 400);

% Uniform active period [1,500]
active_periods = ceil(rand(1, 5000) .* 500);
freq_active_periods = my_pdf(active_periods, 1, 500, 5000);

% Uniform idle periods
% High utilization [1,100]
high_uniform_idle_periods = ceil(rand(1, 5000) .* 100);
% Low utilization [1,400]
low_uniform_idle_periods = ceil(rand(1, 5000) .* 400);

% High utilization uniform pdf
freq_high_uniform_idle_periods = my_pdf(high_uniform_idle_periods, 1, 100, 5000);

% Low utilization uniform pdf
freq_low_uniform_idle_periods = my_pdf(low_uniform_idle_periods, 1, 400, 5000);

% Normal distribution
normal_idle_periods = round(normrnd(100, 20, [1 5000]));
lower_bound = min(normal_idle_periods);
higher_bound = max(normal_idle_periods);

freq_normal_idle_periods = my_pdf(normal_idle_periods, min(normal_idle_periods), max(normal_idle_periods), 5000);


% Exponential distribution
exponential_idle_periods = round(random(makedist('exponential', 'mu', 50), 1, 5000));
freq_exponential_idle_periods = zeros(1, 5000);
freq_exponential_idle_periods = my_pdf(exponential_idle_periods, min(exponential_idle_periods), max(exponential_idle_periods), 5000);

% Trimodal distribution
mode_1 = round(normrnd(50, 10, [1 1666]));
mode_2 = round(normrnd(100, 10, [1 1666]));
mode_3 = round(normrnd(150, 10, [1 1666]));

lower_bound = min([mode_1 mode_2 mode_3]);
higher_bound = max([mode_1 mode_2 mode_3]);

freq_mode_1 = zeros(1, 500);
freq_mode_2 = zeros(1, 500);
freq_mode_3 = zeros(1, 500);

for i = 1:(higher_bound-lower_bound)
   for j = 1:1666
      if mode_1(1,j)==i
        freq_mode_1(1,i) = freq_mode_1(1,i) + 1;
      end
      if mode_2(1,j)==i
        freq_mode_2(1,i) = freq_mode_2(1,i) + 1;
      end
      if mode_3(1,j)==i
        freq_mode_3(1,i) = freq_mode_3(1,i) + 1;
      end
   end
end   
freq_trimodal_idle_periods = (freq_mode_1 + freq_mode_2 + freq_mode_3) ./ 4998;

subplot(6,3,1)
plot(active_periods)
title("Active periods")
ylabel("Active periods [us]")

subplot(6,3,2)
plot(freq_active_periods)
title("Active periods PDF")
xlabel("Active periods [us]")
ylabel("Frequency")

subplot(6,3,3)
hist(active_periods)
title("Active periods histogram")
xlabel("Active periods [us]")
ylabel("Number of samples")

subplot(6,3,4)
plot(high_uniform_idle_periods)
title("High utilization idle periods")
ylabel("Idle periods [us]")

subplot(6,3,5)
plot(freq_high_uniform_idle_periods)
title("High utilization idle periods PDF")
xlabel("Idle periods [us]")
ylabel("Frequency")

subplot(6,3,6)
hist(high_uniform_idle_periods)
title("High utilization idle periods histogram")
xlabel("Idle periods [us]")
ylabel("Number of samples")

subplot(6,3,7)
plot(low_uniform_idle_periods)
title("Low utilization idle periods")
ylabel("Idle periods [us]")

subplot(6,3,8)
plot(freq_low_uniform_idle_periods)
title("Low utilization idle periods PDF")
xlabel("Idle periods [us]")
ylabel("Frequency")

subplot(6,3,9)
hist(low_uniform_idle_periods)
title("Low utilization idle periods histogram")
xlabel("Idle periods [us]")
ylabel("Number of samples")

subplot(6,3,10)
plot(normal_idle_periods)
title("Normal utilization idle periods - μ = 100 us, σ = 20")
ylabel("Idle periods [us]")

subplot(6,3,11)
plot(freq_normal_idle_periods)
title("Normal utilization idle periods - μ = 100 us, σ = 20 PDF")
xlabel("Idle periods [us]")
ylabel("Frequency")

subplot(6,3,12)
hist(normal_idle_periods, 100)
title("Normal utilization idle periods - μ = 100 us, σ = 20 histogram")
xlabel("Idle periods [us]")
ylabel("Number of samples")

subplot(6,3,13)
plot(exponential_idle_periods)
title("Exponential utilization idle periods - μ = 50 us")
ylabel("Idle periods [us]")

subplot(6,3,14)
plot(freq_exponential_idle_periods)
title("Exponential utilization idle periods - μ = 50 us PDF")
xlabel("Idle periods [us]")
ylabel("Frequency")

subplot(6,3,15)
hist(exponential_idle_periods, 100)
title("Exponential utilization idle periods - μ = 50 us histogram")
xlabel("Idle periods [us]")
ylabel("Number of samples")

subplot(6,3,16)
plot([mode_1 mode_2 mode_3])
title("Trimodal utilization idle periods - μ = 50, 100, 150 us, σ = 10 ")
ylabel("Idle periods [us]")

subplot(6,3,17)
plot(freq_trimodal_idle_periods)
title("Trimodal utilization idle periods - μ = 50, 100, 150 us, σ = 10 PDF")
xlabel("Idle periods [us]")
ylabel("Frequency")

subplot(6,3,18)
hist([mode_1 mode_2 mode_3], 100)
title("Trimodal utilization idle periods - μ = 50, 100, 150 us, σ = 10 histogram")
xlabel("Idle periods [us]")
ylabel("Number of samples")

generate_workload('/wl_uniform_high.txt', active_periods, high_uniform_idle_periods);
generate_workload('./wl_uniform_low.txt', active_periods, low_uniform_idle_periods);
generate_workload('./wl_normal.txt', active_periods, normal_idle_periods);
generate_workload('./wl_exponential.txt', active_periods, exponential_idle_periods);
generate_workload('./wl_trimodal.txt', active_periods, [mode_1 mode_2 mode_3]);
   

function x = generate_workload(file_path, active, idle)
    fileID = fopen(file_path, 'w');
    global_time = 0;
    
    for i = 1:length(idle)
        global_time = global_time + active(1,i);
        fprintf(fileID, '%i ', global_time);

        global_time = global_time + idle(1,i);
        fprintf(fileID, '%i\n', global_time);
    end
    
    fclose(fileID);
    x = 1;
end

function freq_array = my_pdf(value_array, lower_bound, higher_bound, samples)
    freq_array = zeros(1, (higher_bound-lower_bound));
    for i = 1:(higher_bound-lower_bound)
       for j = 1:samples 
          if value_array(1,j) == i
              freq_array(1,i) = freq_array(1,i) + 1;
          end
       end
    end   
    freq_array = freq_array ./ samples;
end