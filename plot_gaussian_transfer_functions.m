function plot_gaussian_transfer_functions()
    continuous_input = linspace(-5, 5, 1000);
    % Define Gaussian-shaped transfer functions
    G1 = exp(-continuous_input.^2);           % Gaussian 1
    G2 = exp(-continuous_input.^2 / 2);       % Gaussian 2
    G3 = exp(-continuous_input.^2 / 3);       % Gaussian 3
    G4 = exp(-continuous_input.^2 / 4);       % Gaussian 4
    figure;
    plot(continuous_input, G1, 'r', 'LineWidth', 2); hold on;
    plot(continuous_input, G2, 'g', 'LineWidth', 2); hold on;
    plot(continuous_input, G3, 'b', 'LineWidth', 2); hold on;
    plot(continuous_input, G4, 'k', 'LineWidth', 2); hold on;
    title('Gaussian-shaped Transfer Functions Family', 'FontWeight', 'bold');
    xlabel('Continuous Input', 'FontWeight', 'bold');
    ylabel('Output Transfer Function G(x) Binary Value', 'FontWeight', 'bold');
    ax = gca;
    ax.FontWeight = 'bold';
    legend('G1', 'G2', 'G3', 'G4', 'Location', 'best', 'FontWeight', 'bold');
    grid on;
    box on; 
end
