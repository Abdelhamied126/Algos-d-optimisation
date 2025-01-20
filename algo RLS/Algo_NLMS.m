function [w, y, e] = Algo_NLMS(x, d, P, mu)
    N = length(x);    % nb samples
    w = zeros(P, N);  % Filter coefficients
    y = zeros(N, 1);  % Output signal
    e = zeros(N, 1);  % Error signal
    for n = P:N
       x_vec = x(n:-1:n-P+1);  % Input vector
       y(n) = w(:, n)' * x_vec;  % Filter output
       e(n) = d(n) - y(n);  % Error signal
       w(:, n+1) = w(:, n) - mu * e(n) * x_vec/(x_vec'*x_vec);  % LMS update
    end
end
