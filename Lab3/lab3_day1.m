%load("gmonths.mat");
load("variables/pv_values.mat");
load("variables/SOC_values");
load("variables/raw_efficiency_battery_dcdc");
load("variables/raw_efficiency_pv");
run("config.m");

Power_250 = [pv250(:,1) pv250(:,1).*pv250(:,2)];
Power_500 = [pv500(:,1) pv500(:,1).*pv500(:,2)];
Power_750 = [pv750(:,1) pv750(:,1).*pv750(:,2)];
Power_1000 = [pv1000(:,1) pv1000(:,1).*pv1000(:,2)];

Vmpp_250 = 3.10; Impp_250 = 0.01272;
Vmpp_500= 3.14; Impp_500 = 0.02816;
Vmpp_750= 3.15; Impp_750 = 0.04153;
Vmpp_1000= 3.3; Impp_1000 = 0.05463;

G = [250;500;750;1000];
V = [Vmpp_250;Vmpp_500;Vmpp_750;Vmpp_1000];
I = [Impp_250;Impp_500;Impp_750;Impp_1000];


efficiency_pv(:,1) = raw_efficiency_pv(:,1);
efficiency_pv(:,2) = raw_efficiency_pv(:,2)/100; %% mA -> A

efficiencybatterydcdc(:,1) = 10.^(raw_efficiencybatterydcdc(:,1));
efficiencybatterydcdc(:,2) = raw_efficiencybatterydcdc(:,2) / 100; %% mA -> A

% Interpolation for SOC
x_new = (0:0.1:1);
SOC_1_interpolated = interp1(SOC_1C(:,1), SOC_1C(:,2), x_new);
SOC_1_interpolated = SOC_1_interpolated(2:10);

SOC_2_interpolated = interp1(SOC_2C(:,1), SOC_2C(:,2), x_new);
SOC_2_interpolated = SOC_2_interpolated(2:10);
% I_curves 
I_1 = 3.2 ; %1C = 3200mAh
I_2 = 6.4;  %2C = 6400mAh

x_new = x_new(2:10);
R_V_soc = (SOC_1_interpolated - SOC_2_interpolated) / (I_2-I_1);
V_oc = SOC_2_interpolated + R_V_soc * I_2;

%R and V interpolation with Curve Fitting

