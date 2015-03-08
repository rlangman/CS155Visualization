function [users, movies, user_devs, movie_devs] = ...
    train_gradient_advanced(users, movies, user_devs, movie_devs, ...
    ratings, num_epochs)
% Given some features for users and movies and a list of ratings, trains
%   the features for num_epochs iterations using stochastic gradient
%   descent using the advanced latent features model

    global num_ratings;
    global eta;
    global lambda;
    
    error = getRMSE(users, movies, user_devs, movie_devs, ratings);
    fprintf('Starting RMSE: %f\n', error);
    
    % Apply stochastic gradient descent on a random permutation of the
    % data points for num_epochs iterations
    epoch = 0;
    while epoch < num_epochs
        epoch = epoch + 1;
        
        % Randomly Shuffle the ratings
        ratings = ratings(:, randperm(size(ratings,2)));
        
        % Iterate over every rating and calculate the gradient
        for i=1:num_ratings
            [u, m, r] = get_rating_info(ratings(:, i));
            % Get the error prediction
            e = r - predict(users(:, u), movies(:, m), ...
                user_devs(u), movie_devs(m));
            
            % Gradient of deviations
            user_devs(u) = user_devs(u) - eta * (lambda * user_devs(u) ...
                - 2 * e);
            movie_devs(m) = movie_devs(m) - eta * (lambda*movie_devs(m) ...
                - 2 * e);
            
            % Gradient of user and movie features
            tempU = users(:, u);
            users(:, u) = users(:, u) - eta * (lambda * users(:, u) ...
                - 2 * e * movies(:, m));

            movies(:, m) = movies(:, m) - eta * (lambda * movies(:, m) ...
                - 2 * e * tempU);
        end
        
        error = getRMSE(users, movies, user_devs, movie_devs, ratings);
        fprintf('Epoch %i: %f\n', epoch, error);

    end
    
    fprintf('Stoped after %i epochs\n', epoch);
    error = getRMSE(users, movies, user_devs, movie_devs, ratings);
    fprintf('Ending RMSE: %f\n', error);

end

function [rating] = predict(user, movie, user_dev, movie_dev)
% Given the column vectors for a user and a movie, returns the predicted
%   rating as a continuous variable
    global avg_rating;
    rating = avg_rating + user_dev + movie_dev + transpose(user) * movie;
    
end

function [error] = getRMSE(users, movies, user_devs, movie_devs, ratings)
    global num_ratings;
    
    error = 0.0;
    for i=1:num_ratings
        [u, m, r] = get_rating_info(ratings(:, i));
        prediction = predict(users(:, u), movies(:, m), ...
            user_devs(u), movie_devs(m));
        % We are using squared error
        error = error + (r - prediction)^2;
    end
    
    % Get the rmse
    error = sqrt(error / num_ratings);
    
end
