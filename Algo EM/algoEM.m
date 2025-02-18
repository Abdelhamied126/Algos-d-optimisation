function [theta_c, Q_valeurs, theta_history] = algoEM(vec_x, theta_0)
    % vect_x :vecteur des pixel de l'image
    % Dans theta_0 : 
       % pi1_0
       % pi2_1
       % m1_0
       % m2_1
       % sigma1_0
       % sigma2_0


    epsilon = 1e-3; % condition d'arrêt
    c = 0; % itération c
    max_iter = 1;
    N = length(vec_x);
    theta_history = []; % Historique des paramètres
    Q_valeurs = []; % Historique de Q
    delta = inf; %différence des paramètres entre (c+1) et c
    theta_c = theta_0;


    while delta > epsilon && c < max_iter

        theta_old = theta_c;

        tik = zeros(N,2);

        Q = 0;

      
        tik (:,1) = theta_c(1)*normpdf(vec_x, theta_c(3), sqrt(theta_c(5)))/(theta_c(1)* normpdf(vec_x, theta_c(3), sqrt(theta_c(5))) ...
                        + theta_c(2)*normpdf(vec_x, theta_c(4), sqrt(theta_c(6))));

        tik (:,2) = theta_c(2)*normpdf(vec_x, theta_c(4), sqrt(theta_c(6)))/(theta_c(1)* normpdf(vec_x, theta_c(3), sqrt(theta_c(5))) ...
                        + theta_c(2)*normpdf(vec_x, theta_c(4), sqrt(theta_c(6))));

        Q = Q + tik(:, 1) * log(theta_c(1) * normpdf(vec_x, theta_c(3), sqrt(theta_c(5)))) + ...
                tik(:, 2) * log(theta_c(2) * normpdf(vec_x, theta_c(4), sqrt(theta_c(6))));

        somme_ti1 = sum(tik(:,1));
        somme_ti2 = sum(tik(:,2));

        theta_c(1) = somme_ti1/N; %pi1
        theta_c(2) = somme_ti2/N; %pi2
        theta_c(3) = sum(tik(:,1).*vec_x(:))/somme_ti1; %m1
        theta_c(4) = sum(tik(:,2).*vec_x(:))/somme_ti2; %m2
        theta_c(5) = sum(tik(:, 1) .* (vec_x(:) - theta_c(3)).^2) / somme_ti1; % sigma1^2
        theta_c(6) = sum(tik(:, 2) .* (vec_x(:) - theta_c(4)).^2) / somme_ti2; % sigma2^2
        
        
    
        Q_valeurs = [Q_valeurs; Q];
    
        theta_history = [theta_history; theta_c];
    
        delta = max(abs(theta_c - theta_old));
    
        c = c+1;
    
        fprintf('Itération %d : delta = %.6f\n', c, delta);
    end


end