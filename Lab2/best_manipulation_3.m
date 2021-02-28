y_values = zeros(1,200);
tec_array = zeros(1, 200);
% Evaluation of 1% distortion
figure(1)
for index = 1:length(image_list_3.dir)
    technique = "";
    hungry_blue_value = 0;
    power_reduction = 0;
    
    if(image_list_3.best_power_consumption_1(index)==0 && image_list_3.best_power_consumption_hist_eq_1(index)==0)
        technique = "";
        power_reduction = 0;
        disp("Image " + index + technique);
        tec_array(index) = -1;
        b(index) = bar(categorical(image_list_3.name(index)), power_reduction, 'r');
    elseif(image_list_3.best_power_consumption_1(index) < image_list_3.best_power_consumption_hist_eq_1(index))
        technique = "HE: ";
        power_reduction = image_list_3.best_power_consumption_hist_eq_1(index);
        technique = technique + power_reduction;
        disp("Image " + index + technique);
        tec_array(index) = 0;
        b(index) = bar(categorical(image_list_3.name(index)), power_reduction, 'g');
    else
        technique = "HB@";
        hungry_blue_value = image_list_3.best_hungry_blue_value_1(index);
        power_reduction = image_list_3.best_power_consumption_1(index);
        technique = technique+"("+hungry_blue_value+") " + power_reduction;
        disp("Image " + index + technique);
        tec_array(index) = 1;
        b(index) = bar(categorical(image_list_3.name(index)),power_reduction, 'b');
    end
    hold on
    y_values(index) = power_reduction;
end
title("1% Distortion");
xlabel("Image index");
ylabel("Power reduction %");
mean_value = yline(mean(y_values),'-.b',"Mean Value= "+mean(y_values));
mean_value.Color = [.80 0 .40];


% 5% Distortion
figure(2)
for index = 1:length(image_list_3.dir)
    technique = "";
    hungry_blue_value = 0;
    power_reduction = 0;
    
    if(image_list_3.best_power_consumption_5(index)==0 && image_list_3.best_power_consumption_hist_eq_5(index)==0)
        technique = "";
        power_reduction = 0;
        disp("Image " + index + technique);
        tec_array(index) = -1;
        b(index) = bar(categorical(image_list_3.name(index)), power_reduction, 'r');
    elseif(image_list_3.best_power_consumption_5(index) < image_list_3.best_power_consumption_hist_eq_5(index))
        technique = "HE: ";
        power_reduction = image_list_3.best_power_consumption_hist_eq_5(index);
        technique = technique + power_reduction;
        disp("Image " + index + technique);
        tec_array(index) = 0;
        b(index) = bar(categorical(image_list_3.name(index)), power_reduction, 'g');
    else
        technique = "HB@";
        hungry_blue_value = image_list_3.best_hungry_blue_value_5(index);
        power_reduction = image_list_3.best_power_consumption_5(index);
        technique = technique+"("+hungry_blue_value+") " + power_reduction;
        disp("Image " + index + technique);
        tec_array(index) = 1;
        b(index) = bar(categorical(image_list_3.name(index)),power_reduction, 'b');
    end
    hold on
    y_values(index) = power_reduction;
end

title("5% Distortion");
xlabel("Image index");
ylabel("Power reduction %");
mean_value = yline(mean(y_values),'-.b',"Mean Value= "+mean(y_values));
mean_value.Color = [.80 0 .40];


% 10% Distortion
figure(3)
for index = 1:length(image_list_3.dir)
    technique = "";
    hungry_blue_value = 0;
    power_reduction = 0;
    
    if(image_list_3.best_power_consumption_10(index)==0 && image_list_3.best_power_consumption_hist_eq_10(index)==0)
        technique = "";
        power_reduction = 0;
        disp("Image " + index + technique);
        tec_array(index) = -1;
        b(index) = bar(categorical(image_list_3.name(index)), power_reduction, 'r');
    elseif(image_list_3.best_power_consumption_10(index) < image_list_3.best_power_consumption_hist_eq_10(index))
        technique = "HE: ";
        power_reduction = image_list_3.best_power_consumption_hist_eq_10(index);
        technique = technique + power_reduction;
        disp("Image " + index + technique);
        tec_array(index) = 0;
        b(index) = bar(categorical(image_list_3.name(index)), power_reduction, 'g');
    else
        technique = "HB@";
        hungry_blue_value = image_list_3.best_hungry_blue_value_10(index);
        power_reduction = image_list_3.best_power_consumption_10(index);
        technique = technique+"("+hungry_blue_value+") " + power_reduction;
        disp("Image " + index + technique);
        tec_array(index) = 1;
        b(index) = bar(categorical(image_list_3.name(index)),power_reduction, 'b');
    end
    hold on
    y_values(index) = power_reduction;
end

title("10% Distortion");
xlabel("Image index");
ylabel("Power reduction %");
mean_value = yline(mean(y_values),'-.b',"Mean Value= "+mean(y_values));
mean_value.Color = [.80 0 .40];