function [w, y, e] = Algo_RLS(x, d, P, lambda, delta)

N = length(x);        % Number of samples
w = zeros(P, N);      % Filter coefficients
y = zeros(N, 1);      % Output signal
e = zeros(N, 1);      % Error signal
S = delta^-1 * eye(P); % Initial inverse covariance matrix

for n = P:N
    % Construct the input vector
    x_vec = x(n:-1:n-P+1);
    % Filter output
    y(n) = w(:,n)' * x_vec;
    % Error signal
    e(n) = y(n) - d(n);
    % Gain vector
    K = S * x_vec / (lambda + x_vec' * S * x_vec);
    % Update filter coefficients
    w(:, n+1) = w(:, n) - K * e(n);
    % Update inverse covariance matrix
    S = (S - K * x_vec' * S) / lambda;
end
% Remove last column from w since it exceeds the signal length
w = w(:, 1:N);
end