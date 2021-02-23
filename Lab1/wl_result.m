%
% Single off-state: Idle
%
% fileID = fopen("./wl_results/wl_uniform_high_result.txt", 'r');
% data = textscan(fileID, "%d %f");
% plot(data{1},data{2});
% grid on
% title("Uniform high utilization");
% xlabel("Timeout [us]");
% ylabel("Energy saved [%]");
% saveas(gcf, "wl_uniform_high_result.png");
% 
% fileID = fopen("./wl_results/wl_uniform_low_result.txt", 'r');
% data = textscan(fileID, "%d %f");
% plot(data{1},data{2});
% grid on
% title("Uniform low utilization");
% xlabel("Timeout [us]");
% ylabel("Energy saved [%]");
% saveas(gcf, "wl_uniform_low_result.png");
% 
% fileID = fopen("./wl_results/wl_normal_result.txt", 'r');
% data = textscan(fileID, "%d %f");
% plot(data{1},data{2});
% grid on
% title("Normal utilization");
% xlabel("Timeout [us]");
% ylabel("Energy saved [%]");
% saveas(gcf, "wl_normal_result.png");
% 
% fileID = fopen("./wl_results/wl_exponential_result.txt", 'r');
% data = textscan(fileID, "%d %f");
% plot(data{1},data{2});
% grid on
% title("Exponential utilization");
% xlabel("Timeout [us]");
% ylabel("Energy saved [%]");
% saveas(gcf, "wl_exponential_result.png");
% 
% fileID = fopen("./wl_results/wl_trimodal_result.txt", 'r');
% data = textscan(fileID, "%d %f");
% plot(data{1},data{2});
% grid on
% title("Trimodal utilization");
% xlabel("Timeout [us]");
% ylabel("Energy saved [%]");
% saveas(gcf, "wl_trimodal_result.png");

% fileID = fopen("./wl_results/custom_workload_2_result.txt", 'r');
% data = textscan(fileID, "%d %f");
% plot(data{1},data{2});
% grid on
% title("Custom workload 2 utilization");
% xlabel("Timeout [us]");
% ylabel("Energy saved [%]");
% saveas(gcf, "wl_custom_2_result.png");

% fileID = fopen("./wl_results/custom_workload_1_result.txt", 'r');
% data = textscan(fileID, "%d %f");
% plot(data{1},data{2});
% grid on
% title("Custom workload 1 utilization");
% xlabel("Timeout [us]");
% ylabel("Energy saved [%]");
% saveas(gcf, "wl_custom_1_result.png");
% 
% 

%
% Double off-state: idle and sleep
%

fileID = fopen("./wl_results/wl_uniform_low_result_double_20.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
hold on
grid on
fileID = fopen("./wl_results/wl_uniform_low_result_double_55.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
fileID = fopen("./wl_results/wl_uniform_low_result_double_100.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});

title("Uniform low utilization");
xlabel("Timeout Sleep [us]");
ylabel("Energy saved [%]");
legend("Tidle=20us", "Tidle=55us", "Tidle=100us");
hold off
saveas(gcf, "wl_uniform_low_result_double.png");

fileID = fopen("./wl_results/wl_uniform_high_result_double_20.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
hold on
grid on
fileID = fopen("./wl_results/wl_uniform_high_result_double_55.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
fileID = fopen("./wl_results/wl_uniform_high_result_double_100.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});

title("Uniform high utilization");
xlabel("Timeout Sleep [us]");
ylabel("Energy saved [%]");
legend("Tidle=20us", "Tidle=55us", "Tidle=100us");
hold off
saveas(gcf, "wl_uniform_high_result_double.png");

fileID = fopen("./wl_results/wl_normal_result_double_20.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
hold on
grid on
fileID = fopen("./wl_results/wl_normal_result_double_55.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
fileID = fopen("./wl_results/wl_normal_result_double_100.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});

title("Normal utilization");
xlabel("Timeout Sleep [us]");
ylabel("Energy saved [%]");
legend("Tidle=20us", "Tidle=55us", "Tidle=100us");
hold off
saveas(gcf, "wl_normal_result_double.png");

fileID = fopen("./wl_results/wl_exponential_result_double_20.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
hold on
grid on
fileID = fopen("./wl_results/wl_exponential_result_double_55.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
fileID = fopen("./wl_results/wl_exponential_result_double_100.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});

title("Exponential utilization");
xlabel("Timeout Sleep [us]");
ylabel("Energy saved [%]");
legend("Tidle=20us", "Tidle=55us", "Tidle=100us");
hold off
saveas(gcf, "wl_exponential_result_double.png");

fileID = fopen("./wl_results/wl_trimodal_result_double_20.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
hold on
grid on
fileID = fopen("./wl_results/wl_trimodal_result_double_55.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
fileID = fopen("./wl_results/wl_trimodal_result_double_100.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});

title("Trimodal utilization");
xlabel("Timeout Sleep [us]");
ylabel("Energy saved [%]");
legend("Tidle=20us", "Tidle=55us", "Tidle=100us");
hold off
saveas(gcf, "wl_trimodal_result_double.png");

fileID = fopen("./wl_results/custom_workload_1_result_double_20.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
hold on
grid on
fileID = fopen("./wl_results/custom_workload_1_result_double_55.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
fileID = fopen("./wl_results/custom_workload_1_result_double_100.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});

title("Custom workload 1");
xlabel("Timeout Sleep [us]");
ylabel("Energy saved [%]");
legend("Tidle=20us", "Tidle=55us", "Tidle=100us");
hold off
saveas(gcf, "custom_workload_1_result_double.png");

fileID = fopen("./wl_results/custom_workload_2_result_double_20.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
hold on
grid on
fileID = fopen("./wl_results/custom_workload_2_result_double_55.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});
fileID = fopen("./wl_results/custom_workload_2_result_double_100.txt", 'r');
data = textscan(fileID, "%d %f");
plot(data{1},data{2});

title("Custom workload 2");
xlabel("Timeout Sleep [us]");
ylabel("Energy saved [%]");
legend("Tidle=20us", "Tidle=55us", "Tidle=100us");
hold off
saveas(gcf, "custom_workload_2_result_double.png");