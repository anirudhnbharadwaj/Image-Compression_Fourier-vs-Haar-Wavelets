% Main script to compare Fourier and Haar compression methods for three images

% List of images
images = {'/MATLAB Drive/final_assignment/lena.png', 
        '/MATLAB Drive/final_assignment/cameraman.png', 
        '/MATLAB Drive/final_assignment/peppers.png'};

image_names = {'Lena', 'Cameraman', 'Peppers'};

% Create the main Outputs directory if it doesn't exist
if ~exist('/MATLAB Drive/final_assignment/Outputs', 'dir')
    mkdir('/MATLAB Drive/final_assignment/Outputs');
end

% Loop over each image
for img_idx = 1:length(images)
    % Load the image
    im = imread(images{img_idx});
    
    % Convert to grayscale 
    if ndims(im) == 3
        im = rgb2gray(im);
    end
    im = double(im); % Cast to double

    % Debug: Check image size after conversion
    disp(['Image size after conversion for ', image_names{img_idx}, ': ', num2str(size(im))]);

    % Resize the image to 256x256
    im = imresize(im, [256 256]);
    
    % Debug: Check image size after resizing
    disp(['Image size after resizing for ', image_names{img_idx}, ': ', num2str(size(im))]);

    % Initialize vectors to store SNR values
    compratios = 2:50;
    snr_fourier = zeros(size(compratios));
    snr_haar = zeros(size(compratios));

    % Loop over compression ratios
    for i = 1:length(compratios)
        r = compratios(i);
        % Compute SNR for Fourier method
        try
            [snr_fourier(i), ~] = compimFourier(im, r);
        catch e
            disp(['Error in compimFourier for ', image_names{img_idx}, ' at ratio ', num2str(r), ': ', e.message]);
        end
        % Compute SNR for Haar method
        try
            [snr_haar(i), ~] = compimHaar(im, r);
        catch e
            disp(['Error in compimHaar for ', image_names{img_idx}, ' at ratio ', num2str(r), ': ', e.message]);
        end
    end

    % Create a subdirectory for the current image if it doesn't exist
    output_dir = fullfile('Outputs', image_names{img_idx});
    if ~exist(/MATLAB Drive/final_assignment/output_dir, 'dir')
        mkdir(/MATLAB Drive/final_assignment/output_dir);
    end

    % Plot the results
    figure;
    plot(compratios, snr_fourier, 'b-', 'LineWidth', 2, 'DisplayName', 'Fourier');
    hold on;
    plot(compratios, snr_haar, 'r-', 'LineWidth', 2, 'DisplayName', 'Haar');
    xlabel('Compression Ratio');
    ylabel('SNR (dB)');
    title(['SNR vs Compression Ratio for ', image_names{img_idx}, ' Image']);
    legend;
    grid on;
    % Save the plot 
    saveas(gcf, fullfile(output_dir, [image_names{img_idx}, '_snr_plot.png']));

    % Save compressed images at compression ratio 25 
    [~, outim_fourier] = compimFourier(im, 25);
    [~, outim_haar] = compimHaar(im, 25);
    imwrite(outim_fourier, fullfile(output_dir, [image_names{img_idx}, '_fourier_cr25.png']));
    imwrite(outim_haar, fullfile(output_dir, [image_names{img_idx}, '_haar_cr25.png']));
    imwrite(uint8(im), fullfile(output_dir, [image_names{img_idx}, '_original.png'])); % Save original
end