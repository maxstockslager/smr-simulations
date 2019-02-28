function my_box_plot(data, x)

boxWidth = 0.25;
capWidth = 0.1;
color = 'k';
LineWidth = 1; 

meanVal = mean(data);
medianVal = median(data);
top = prctile(data, 75);
bottom = prctile(data, 25);
topBar = prctile(data, 90);
bottomBar = prctile(data, 10);

% draw outer box
left = x - boxWidth;
right = x + boxWidth;
plot([left, right], [bottom, bottom], color, 'LineWidth', LineWidth); % bottom
hold on
plot([left, right], [top, top], color, 'LineWidth', LineWidth); % top
plot([left, left], [top, bottom], color, 'LineWidth', LineWidth); % left
plot([right, right], [top, bottom], color, 'LineWidth', LineWidth); % right
plot([x, x], [top, topBar], color, 'LineWidth', LineWidth); % top error bar
plot([x, x], [bottom, bottomBar], color, 'LineWidth', LineWidth); % bottom error bar
plot([left, right], [medianVal, medianVal], color, 'LineWidth', LineWidth); % median
plot([x - capWidth, x + capWidth], [topBar, topBar], color, 'LineWidth', LineWidth); % top cap
plot([x - capWidth, x + capWidth], [bottomBar, bottomBar], color, 'LineWidth', LineWidth); % lower cap

% plot the mean as a small box
plot(x, meanVal, [color, 's'], 'MarkerSize', 5);
end