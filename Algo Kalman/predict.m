function x_next_pred = predict(x_current_pred, y_obs, G_current, A, b, C)
    % Met à jour la prédiction x̂_{n+1} à partir de x̂_n et de y_n
    %
    % Entrées :
    %   - x_current_pred : Prédiction actuelle x̂_n
    %   - y_obs : Observation actuelle y_n
    %   - G_current : Gain de Kalman actuel G_n
    %   - A : Matrice de transition d'état
    %   - b : Bruit du processus (souvent nul)
    %   - C : Matrice d'observation
    %
    % Sorties :
    %   - x_next_pred : Prédiction mise à jour x̂_{n+1}

    % Étape 1 : Calcul de l'innovation α_n
    alpha = y_obs - C * x_current_pred;

    % Étape 2 : Mise à jour de la prédiction x̂_{n+1}
    x_next_pred = A * (x_current_pred - G_current * alpha);
end