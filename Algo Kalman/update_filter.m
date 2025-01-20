function [G_pred, P_pred_next] = update_filter(G_current, P_current, A, Qb, C, Qv)
    % Met à jour G_{n+1} et P_{n+1}^-
    %
    % Entrées :
    %   - G_current : Gain de Kalman actuel G_n
    %   - P_current_pred : Covariance prédite actuelle P_n^-
    %   - A : Matrice d'évolution
    %   - Qb : Covariance du bruit de processus
    %   - C : Matrice d'observation
    %   - Qv : Covariance du bruit de mesure
    %
    % Sorties :
    %   - G_next : Gain de Kalman G_{n+1}
    %   - P_next_pred : Covariance prédite P_{n+1}^-

    % Mise à jour de la covariance de l'erreur prédite P(n+1)
    P_pred = (eye(size(P_current))- G_current*C) *  P_current;
    
    
    
    P_pred_next =A* P_pred* A' +Qb;
   

    % Mise à jour du gain de Kalman G(n+1)
    G_pred = - P_pred_next * C / (C' * P_pred_next * C + Qv);
end