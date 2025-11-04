%% Asymmetric Tension Imprint Model (ATIM) - Example
% This script demonstrates the application of the Asymmetric Tension 
% Imprint Model for predicting surface roughness in cold rolling.
%
% Reference: "Potential of asymmetric strip tension to control the 
% surface roughness in cold rolling"
% Authors: C. Schulte, X. Li, M. Zhang, D. Bailly, S. Stemmler, H. Vallery
% Journal of Manufacturing Processes, 2025

clear; clc; close all;

% Add functions folder to path
addpath('functions');

%% Model Parameters
% Initialize parameters structure
params = struct();
params.Ra_in = 1.5000;          % Initial strip roughness [μm]
params.Ra_walze = 2.3800;       % Work roll roughness [μm]
params.F_90 = 1.9999;           % Specific force at 90% transfer [N/mm]
params.F_max = 3;               % Maximum specific force [N/mm]
params.dRa_in = 0.0027;         % Gradient of inlet roughness [μm/(N/mm)]
params.dF_90 = 0.0018;          % Gradient of F_90 [-]
params.t_rel_limit = [-56 161]; % Relative tension limits [N/mm]
params.dRa_walze = 0.0022;      % Gradient of roll roughness [μm/(N/mm)]
params.C_roll = 1.1100;         % Roll roughness transfer coefficient [-]

%% Create Force and Tension Ranges
% Specific force range [N/mm]
F_range = linspace(0.5, params.F_max, 100);

% Relative tension range [N/mm]
t_rel_range = linspace(params.t_rel_limit(1), params.t_rel_limit(2), 50);

% Create meshgrid for 3D visualization
[F_mesh, t_rel_mesh] = meshgrid(F_range, t_rel_range);

%% Calculate Surface Roughness
% Initialize roughness matrix
Ra_mesh = zeros(size(F_mesh));

% Calculate roughness for each combination of F and t_rel
for i = 1:length(t_rel_range)
    for j = 1:length(F_range)
        Ra_mesh(i,j) = imprintModel(F_mesh(i,j), t_rel_mesh(i,j), params);
    end
end

%% Figure 1: 3D Surface Plot
figure('Name', 'ATIM - 3D Surface', 'Position', [100 100 800 600]);
surf(F_mesh, t_rel_mesh, Ra_mesh, 'EdgeAlpha', 0.3);
xlabel('Specific Force F [N/mm]', 'FontSize', 12);
ylabel('Relative Tension t_{rel} [N/mm]', 'FontSize', 12);
zlabel('Surface Roughness Ra [μm]', 'FontSize', 12);
title('Asymmetric Tension Imprint Model (ATIM)', 'FontSize', 14);
colorbar;
colormap('jet');
grid on;
view(-30, 30);

%% Figure 2: 2D Contour Plot
figure('Name', 'ATIM - Contour Plot', 'Position', [150 150 800 600]);
contourf(F_mesh, t_rel_mesh, Ra_mesh, 20);
xlabel('Specific Force F [N/mm]', 'FontSize', 12);
ylabel('Relative Tension t_{rel} [N/mm]', 'FontSize', 12);
title('Surface Roughness Contour Map', 'FontSize', 14);
colorbar;
colormap('jet');
grid on;
hold on;
% Add contour lines
contour(F_mesh, t_rel_mesh, Ra_mesh, 10, 'k', 'LineWidth', 0.5);
hold off;

%% Figure 3: Effect of Asymmetric Tension at Fixed Forces
figure('Name', 'ATIM - Tension Effect', 'Position', [200 200 800 600]);

% Select specific force values
F_selected = [1.0, 1.5, 2.0, 2.5, 3.0];
colors = lines(length(F_selected));

hold on;
for i = 1:length(F_selected)
    Ra_temp = imprintModel(F_selected(i), t_rel_range, params);
    plot(t_rel_range, Ra_temp, 'LineWidth', 2, 'Color', colors(i,:), ...
         'DisplayName', sprintf('F = %.1f N/mm', F_selected(i)));
end
hold off;

xlabel('Relative Tension t_{rel} [N/mm]', 'FontSize', 12);
ylabel('Surface Roughness Ra [μm]', 'FontSize', 12);
title('Effect of Asymmetric Tension on Surface Roughness', 'FontSize', 14);
legend('Location', 'best', 'FontSize', 10);
grid on;

%% Figure 4: Effect of Rolling Force at Fixed Tensions
figure('Name', 'ATIM - Force Effect', 'Position', [250 250 800 600]);

% Select specific tension values
t_rel_selected = [-50, -25, 0, 25, 50, 100, 150];
colors2 = lines(length(t_rel_selected));

hold on;
for i = 1:length(t_rel_selected)
    Ra_temp = imprintModel(F_range, t_rel_selected(i), params);
    plot(F_range, Ra_temp, 'LineWidth', 2, 'Color', colors2(i,:), ...
         'DisplayName', sprintf('t_{rel} = %d N/mm', t_rel_selected(i)));
end
hold off;

xlabel('Specific Force F [N/mm]', 'FontSize', 12);
ylabel('Surface Roughness Ra [μm]', 'FontSize', 12);
title('Effect of Rolling Force on Surface Roughness', 'FontSize', 14);
legend('Location', 'best', 'FontSize', 9);
grid on;

%% Display Parameter Summary
fprintf('\n=== Asymmetric Tension Imprint Model Parameters ===\n');
fprintf('Initial strip roughness (Ra_in):      %.4f μm\n', params.Ra_in);
fprintf('Work roll roughness (Ra_walze):       %.4f μm\n', params.Ra_walze);
fprintf('Force at 90%% transfer (F_90):         %.4f N/mm\n', params.F_90);
fprintf('Maximum force (F_max):                %.4f N/mm\n', params.F_max);
fprintf('Inlet roughness gradient (dRa_in):    %.4f μm/(N/mm)\n', params.dRa_in);
fprintf('F_90 gradient (dF_90):                %.4f\n', params.dF_90);
fprintf('Tension limits (t_rel_limit):         [%d %d] N/mm\n', params.t_rel_limit);
fprintf('Roll roughness gradient (dRa_walze):  %.4f μm/(N/mm)\n', params.dRa_walze);
fprintf('Roll transfer coefficient (C_roll):   %.4f\n', params.C_roll);
fprintf('===================================================\n\n');

%% Example Calculation
fprintf('=== Example Calculation ===\n');
F_example = 2.0;
t_rel_example = 50;
Ra_result = imprintModel(F_example, t_rel_example, params);
fprintf('For F = %.2f N/mm and t_rel = %.0f N/mm:\n', F_example, t_rel_example);
fprintf('Predicted surface roughness Ra = %.4f μm\n', Ra_result);
fprintf('===========================\n\n');
