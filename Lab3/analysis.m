%% Parallel scheduling
run("config.m");
sim('simulation.slx',sim_length)

V_sensors = 3.3;
time_window = 500;
% Parallel sensors
micP = micI(1:time_window)*V_sensors; 
airP = airI(1:time_window)*V_sensors; 
methP = methI(1:time_window)*V_sensors; 
tempP = tempI(1:time_window)*V_sensors; 
mcP = mcI(1:time_window)*V_sensors; 
zbP = zbI(1:time_window)*V_sensors; 
totalP = (micP+airP+methP+tempP+mcP+zbP);

figure(1)
plot(micP, 'LineWidth',2); hold on;
plot(airP,'LineWidth',2); hold on;
plot(methP,'LineWidth',2); hold on;
plot(tempP,'LineWidth',2); hold on;
plot(mcP,'LineWidth',2); hold on;
plot(zbP,'LineWidth',2); hold on;
%plot(totalP);
legend("mic","air","meth","temp","memory+control","tx","total");
title("Power Load");
xlabel("Time [s]");
ylabel("Power [W]");

%PV 
pvP = PVcurrent.*PVvoltage;

figure(2);
plot(pvP,'LineWidth',2); hold on;
plot(Gcurve/max(Gcurve),'LineWidth',2); hold on;
title("Photovoltaic cell power");
legend("Power", "Irradiance normalized");
xlabel("Time [s]");
ylabel("Power [W]");

%Battery
batteryP = battCurrent .* battVoltage;

figure(3);
plot(battSOC,'LineWidth',2); hold on;
plot(battVoltage,'LineWidth',2); hold on;
plot(Gcurve/max(Gcurve),'LineWidth',2); hold on;
title("Battery");
xlabel("Time [s]");
legend("State of charge", "Voltage", "Irradiance normalized");

% Battery DC-DC converter
figure(4);
plot(efficiencyBattery(1:250),'LineWidth',2); hold on;
plot(totalP(1:250)/V_sensors,'LineWidth',2);
title("Battery efficiency");
xlabel("Time [s]");
legend("Efficiency", "I_{Load}");

% PVV is enough?
figure(5);
plot(activePV);hold on;
plot(Gcurve/max(Gcurve),'LineWidth',2); hold on;
xlabel("Time [s]");
ylabel("PV is enough?");
legend("PV","Irradiance normalized");

%% Sequential scheduling: sorted by I (should be better for battery lifetime)
air_delay = 0; methane_delay = 0; temp_delay = 0; mic_delay = 0; mc_delay = 0; transmit_delay = 0;
methane_delay = air_time; 
temp_delay = methane_delay + methane_time; 
mic_delay = temp_delay + temp_time;
mc_delay = mic_delay + mic_time; 
transmit_delay = mc_delay + mc_time;
period = 240;

air_pulse = (air_time * 100)/period; 
methane_pulse = (methane_time * 100)/period; 
temp_pulse = (temp_time *100)/period; 
mic_pulse = (mic_time * 100)/period; 
mc_pulse = (mc_time*100)/period; 
transmit_pulse = (transmit_time * 100)/period; 

sim('simulation.slx',sim_length)

micP = micI(1:time_window)*V_sensors; 
airP = airI(1:time_window)*V_sensors; 
methP = methI(1:time_window)*V_sensors; 
tempP = tempI(1:time_window)*V_sensors; 
mcP = mcI(1:time_window)*V_sensors; 
zbP = zbI(1:time_window)*V_sensors; 
totalP = (micP+airP+methP+tempP+mcP+zbP);

figure(1)
plot(micP, 'LineWidth',2); hold on;
plot(airP,'LineWidth',2); hold on;
plot(methP,'LineWidth',2); hold on;
plot(tempP,'LineWidth',2); hold on;
plot(mcP,'LineWidth',2); hold on;
plot(zbP,'LineWidth',2); hold on;
%plot(totalP);
legend("mic","air","meth","temp","memory+control","tx","total");
title("Power Load");
xlabel("Time [s]");
ylabel("Power [W]");

%PV 
pvP = PVcurrent.*PVvoltage;

figure(2);
plot(pvP,'LineWidth',2); hold on;
plot(Gcurve/max(Gcurve),'LineWidth',2); hold on;
title("Photovoltaic cell power");
legend("Power", "Irradiance normalized");
xlabel("Time [s]");
ylabel("Power [W]");

%Battery
batteryP = battCurrent .* battVoltage;

figure(3);
plot(battSOC,'LineWidth',2); hold on;
plot(battVoltage,'LineWidth',2); hold on;
plot(Gcurve/max(Gcurve),'LineWidth',2); hold on;
title("Battery");
xlabel("Time [s]");
legend("State of charge", "Voltage", "Irradiance normalized");

% Battery DC-DC converter
figure(4);
plot(efficiencyBattery(1:250),'LineWidth',2); hold on;
plot(totalP(1:250)/V_sensors,'LineWidth',2);
title("Battery efficiency");
xlabel("Time [s]");
legend("Efficiency", "I_{Load}");

% PVV is enough?
figure(5);
plot(activePV);hold on;
plot(Gcurve/max(Gcurve),'LineWidth',2); hold on;
xlabel("Time [s]");
ylabel("PV is enough?");
legend("PV","Irradiance normalized");

%% Mixed solution: meth,temp,mic together

air_delay = 0; methane_delay = 0; temp_delay = 0; mic_delay = 0; mc_delay = 0; transmit_delay = 0;
methane_delay = air_time; 
temp_delay = methane_delay; 
mic_delay = temp_delay;
mc_delay = mic_delay + methane_time; 
transmit_delay = mc_delay + mc_time;
period = 240;


air_pulse = (air_time * 100)/period; 
methane_pulse = (methane_time * 100)/period; 
temp_pulse = (temp_time *100)/period; 
mic_pulse = (mic_time * 100)/period; 
mc_pulse = (mc_time*100)/period; 
transmit_pulse = (transmit_time * 100)/period; 

sim('simulation.slx',sim_length)

%% Idle periods

air_delay = 0; methane_delay = 0; temp_delay = 0; mic_delay = 0; mc_delay = 0; transmit_delay = 0;
methane_delay = air_time; 
temp_delay = 60 + methane_delay; 
mic_delay = temp_delay;
mc_delay = mic_delay + methane_time + 60; 
transmit_delay = mc_delay + mc_time;
period = 120;


air_pulse = (air_time * 100)/period; 
methane_pulse = (methane_time * 100)/period; 
temp_pulse = (temp_time *100)/period; 
mic_pulse = (mic_time * 100)/period; 
mc_pulse = (mc_time*100)/period; 
transmit_pulse = (transmit_time * 100)/period; 

sim('simulation.slx',sim_length)

%% Architectural tests

air_delay = 0; methane_delay = 0; temp_delay = 0; mic_delay = 0; mc_delay = 0; transmit_delay = 0;
methane_delay = air_time; 
temp_delay = methane_delay + methane_time; 
mic_delay = temp_delay + temp_time;
mc_delay = mic_delay + mic_time; 
transmit_delay = mc_delay + mc_time;
period = 240;


air_pulse = (air_time * 100)/period; 
methane_pulse = (methane_time * 100)/period; 
temp_pulse = (temp_time *100)/period; 
mic_pulse = (mic_time * 100)/period; 
mc_pulse = (mc_time*100)/period; 
transmit_pulse = (transmit_time * 100)/period; 

sim('simulation_parallel.slx',sim_length)
sim('simulation_series.slx',sim_length)
sim('simulation_pv_parallel.slx',sim_length)
sim('simulation_pv_series.slx',sim_length)
