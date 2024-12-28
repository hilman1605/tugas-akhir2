% Main Script to Integrate All Functions

clear all; close all;

% Basic Parameters
Fs = 32000;              % Sampling frequency
duration = 0.02;         % Signal duration in seconds
N = Fs * duration;       % Number of samples
t = (0:N - 1) / Fs;      % Time vector

% Generate DTMF tones
dtmf_matrix = [697 941; 1477 0];        % DTMF frequency matrix
dtmf_row = containers.Map({'3', '#'}, {1, 2}); % DTMF 
dtmf_col = containers.Map({'3', '#'}, {1, 1});

tones = [
    sin(2 * pi * dtmf_matrix(1, dtmf_row('3')) * t) + sin(2 * pi * dtmf_matrix(2, dtmf_col('3')) * t);
    sin(2 * pi * dtmf_matrix(1, dtmf_row('#')) * t) + sin(2 * pi * dtmf_matrix(2, dtmf_col('#')) * t)
    ];

% Generate base noise and tones signal
base_signal = [(4*rand(1, 1280))-2, ...   % Initial noise
               tones(2, :), ...          % Tone '#'
               tones(2, :), ...          % Tone '#'
               tones(1, :), ...          % Tone '3'
               tones(2, :),...          % Tone '#'
               4*(rand(1, 1280))-2];      % Final noise

% Plot the base signal
figure;
plot(base_signal);
title('Base Signal with Noise and Tones');
xlabel('Sample Number');
ylabel('Amplitude');
grid on;

% SNR Conditions to process
snr_conditions = {'+20 dB','+10 dB', '+5 dB', '0 dB', '-10 dB','-20 dB'};
input_signals = {awgn(base_signal, 20, 'measured'),...
                awgn(base_signal, 10, 'measured'),...
                awgn(base_signal, 5, 'measured'),...
                awgn(base_signal, 0, 'measured'),...
                awgn(base_signal, -10, 'measured'),...
                awgn(base_signal, -20, 'measured')};

% Plot AWGN signals
figure;
for i = 1:length(snr_conditions)
    subplot(2, 3, i);
    plot(input_signals{i});
    title(['After AWGN Signal at ', snr_conditions{i}]);
    xlabel('Sample Number');
    ylabel('Amplitude');
    grid on;
end

% Frame parameters
frame_size = 32;                         % Frame size
batch_size = 20;                         % Batch size

% DTMF frequencies
dtmf_freqs = [697, 941, 1477];

% Precompute reference sines and cosines
[refsin_697, refcos_697] = lut_697();
[refsin_941, refcos_941] = lut_941();
[refsin_1477, refcos_1477] = lut_1477();

refsins = [refsin_697; refsin_941; refsin_1477];
refcosines = [refcos_697; refcos_941; refcos_1477];

fprintf('Currently processing condition without AWGN.\n');
    
% Step 1: Multiply input signal with reference sine and cosine
mult_sinsignal = sin_mult(base_signal, refsins);
mult_cossignal = cosines_mult(base_signal, refcosines);

% Step 2: Accumulate data for framing
[acc_sinsignal, acc_cossignal] = accu(mult_sinsignal, mult_cossignal, frame_size);

% Step 3: Calculate total power from sin and cos accumulations
total_power = total_calc(acc_sinsignal, acc_cossignal);

% Step 4: Perform sliding window batch summation
batch_sums = sliding(total_power, batch_size);

% Step 5: Flagging for specific DTMF frequencies [941 Hz and 1477 Hz]
[detect_enable_941, detect_enable_1477, precision_enable] = flagging(batch_sums);

% Step 6: Precision analysis if flagging detects conditions
if precision_enable
    [max_idx, max_value, detect_enable] = precision(batch_sums);
    if detect_enable
        fprintf('Deteksi selesai dengan precision_enable = 1 dan detect_enable = 1.\n');
    end
else
    fprintf('Tidak terdeteksi sinyal flag.\n');
end

figure;
hold on;
for freq_idx = 1:3
    plot(1:size(batch_sums, 1), batch_sums(:, freq_idx), 'DisplayName', ['Frequency ', num2str(dtmf_freqs(freq_idx)), ' Hz']);
end
xlabel('Sliding Window Index');
ylabel('Accumulated Power (Batch)');
title('Sliding Window Batch Accumulation for DTMF Frequencies');
legend('show');
grid on;

% Create figure for all subplots
figure;
num_conditions = length(snr_conditions);

% Process each SNR condition
for i = 1:num_conditions
    inputsignal = input_signals{i};
    
    fprintf('Currently processing AWGN condition: %s\n', snr_conditions{i});
    
    % Step 1: Multiply input signal with reference sine and cosine
    mult_sinsignal = sin_mult(inputsignal, refsins);
    mult_cossignal = cosines_mult(inputsignal, refcosines);

    % Step 2: Accumulate data for framing
    [acc_sinsignal, acc_cossignal] = accu(mult_sinsignal, mult_cossignal, frame_size);

    % Step 3: Calculate total power from sin and cos accumulations
    total_power = total_calc(acc_sinsignal, acc_cossignal);

    % Step 4: Perform sliding window batch summation
    batch_sums = sliding(total_power, batch_size);

    % Step 5: Flagging for specific DTMF frequencies [941 Hz and 1477 Hz]
    [detect_enable_941, detect_enable_1477, precision_enable] = flagging(batch_sums);

    % Step 6: Precision analysis if flagging detects conditions
    if precision_enable
        [max_idx, max_value, detect_enable] = precision(batch_sums);
        if detect_enable
            fprintf('Deteksi selesai dengan precision_enable = 1 dan detect_enable = 1.\n');
        end
    else
        fprintf('Tidak terdeteksi sinyal flag.\n');
    end

    % Visualization of sliding window results using subplot
    subplot(2, 3, i);  % Adjust subplot grid as necessary
    hold on;
    for freq_idx = 1:3
        plot(1:size(batch_sums, 1), batch_sums(:, freq_idx), 'DisplayName', ['Frequency ', num2str(dtmf_freqs(freq_idx)), ' Hz']);
    end
    xlabel('Sliding Window Index');
    ylabel('Accumulated Power (Batch)');
    title(['SNR ', snr_conditions{i}]);
    legend('show');
    grid on;
    hold off;
end
