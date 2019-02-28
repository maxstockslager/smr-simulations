%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function plot_results(results, results_filt, qc_settings)

marker_size = 10; 

subplot(3, 3, 1)
plot(results.transit_time*1000, results.height, 'r.', 'MarkerSize', marker_size);
hold on
plot(results_filt.transit_time*1000, results_filt.height, 'b.', 'MarkerSize', marker_size);
xlabel('Estimated transit time (ms)');
ylabel('Corrected peak height (Hz)');

subplot(3, 3, 2)
% my_box_plot(results.rough_amplitude, 1)
my_box_plot(results.height, 2);
my_box_plot(results_filt.height, 3);
set(gca, 'XTick', [1 2 3])
set(gca, 'XTickLabel', {'Uncorrected', 'Corrected', 'After QC'});
ylabel('Peak height (Hz)');

% subplot(3, 3, 3)
% plot(results.rough_amplitude, results.height, 'r.', 'MarkerSize', marker_size);
% hold on
% plot(results_filt.rough_amplitude, results_filt.height, 'b.', 'MarkerSize', marker_size)
% axLimits = [min([get(gca, 'XLim'), get(gca, 'YLim')]), max([get(gca, 'XLim'), get(gca, 'YLim')])];
% axis([axLimits, axLimits]);
% axis square
% plot(axLimits, axLimits, 'Color', 0.65*[1 1 1]);
% xlabel('Measured peak height (Hz)');
% ylabel('Corrected peak height (Hz)');

subplot(3, 3, 4)
plot(results.transit_time*1000, results.horiz_optim_score, 'r.', 'MarkerSize', marker_size);
hold on
plot(results_filt.transit_time*1000, results_filt.horiz_optim_score, 'b.', 'MarkerSize', marker_size);
plot(get(gca, 'XLim'), qc_settings.horiz_optim_score_threshold*[1 1], 'r--');
xlabel('Estimated transit time (ms)');
ylabel('Horizontal objective function score');

subplot(3, 3, 5)
plot(results.height, results.vert_optim_score, 'r.', 'MarkerSize', marker_size);
hold on
plot(results_filt.height, results_filt.vert_optim_score, 'b.', 'MarkerSize', marker_size);
plot(get(gca, 'XLim'), qc_settings.vert_optim_score_threshold*[1 1], 'r--');
xlabel('Estimated peak height (Hz)');
ylabel('Vertical objective function score');

subplot(3, 3, 6)
histogram(results_filt.height, 30)
hold on
xlabel('Corrected peak height (Hz)');
set(gca, 'XLim', [0, max(get(gca, 'XLim'))]);

% subplot(3, 3, 7)
% plot(results.transit_time*1000, results.rough_amplitude, 'r.', 'MarkerSize', marker_size);
% hold on
% plot(results_filt.transit_time*1000, results_filt.rough_amplitude, 'b.', 'MarkerSize', marker_size);
% hold on
% xlabel('Estimated transit time (ms)');
% ylabel('Uncorrected peak height (Hz)');

end
    