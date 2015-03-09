function [users, movies] = train_als(users, movies, ratings, num_epochs)
% Given some features for users and movies and a list of ratings, trains
%   the features with alternatinve least squares for num_epochs iterations
    global num_users;
    global num_movies;
    global num_ratings;
    
    % For this specific implementation, we will create a partially
    % incomplete rating matrix.
    ratingsM = zeros(num_users, num_movies);
    
    for i=1:num_ratings
        [u, m, r] = get_rating_info(ratings(:, i));
        ratingsM(u, m) = r;
    end
    
    error = getRMSE(users, movies, ratings);
    fprintf('Starting RMSE: %f\n', error);
    
    % Apply ALS num_epochs times
    epoch = 0;
    while epoch < num_epochs
        epoch = epoch + 1;
        
        % First iterate over all user columns
        for u=1:num_users
            users(:, u) = optU(u, movies, ratingsM);
        end
        for m=1:num_movies
            movies(:, m) = optM(m, users, ratingsM);
        end
        
        error = getRMSE(users, movies, ratings);
        fprintf('Epoch %i: %f\n', epoch, error);

    end
    
    fprintf('Stoped after %i epochs\n', epoch);
    error = getRMSE(users, movies, ratings);
    fprintf('Ending RMSE: %f\n', error);

end

function [rating] = predict(user, movie)
% Given the column vectors for a user and a movie, returns the predicted
%   rating as a continuous variable
    rating = transpose(user) * movie;
    
end

function [opt] = optU(u, movies, ratingsM)
% Given A user_id u, a matrix of movie features, and a matrix of ratings
%   where 0 indicates no rating, returns the optimal matrix u_i
    global lambda;
    global num_features;
    global num_movies;
    sum1 = zeros(num_features, num_features);
    sum2 = zeros(num_features, 1);
    for m=1:num_movies
        if ratingsM(u, m) ~= 0
            movie = movies(:, m);
            sum1 = sum1 + movie * transpose(movie);
            sum2 = sum2 + ratingsM(u, m) * movie;
        end
    end
    opt = 2 * inv(lambda * eye(num_features) + 2 * sum1) * sum2;
end

function [opt] = optM(m, users, ratingsM)
% Given A user_id u, a matrix of movie features, and a matrix of ratings
%   where 0 indicates no rating, returns the optimal matrix u_i
    global lambda;
    global num_features;
    global num_users;
    sum1 = zeros(num_features, num_features);
    sum2 = zeros(num_features, 1);
    for u=1:num_users
        if ratingsM(u, m) ~= 0
            user = users(:, u);
            sum1 = sum1 + user * transpose(user);
            sum2 = sum2 + ratingsM(u, m) * user;
        end
    end
    opt = 2 * inv(lambda * eye(num_features) + 2 * sum1) * sum2;
end



function [error] = getRMSE(users, movies, ratings)
    global num_ratings;
    
    error = 0.0;
    
    for i=1:num_ratings
        [u, m, r] = get_rating_info(ratings(:, i));
        prediction = predict(users(:, u), movies(:, m));
        % We are using squared error
        error = error + (r - prediction)^2;
    end
    
    % Get the rmse
    error = sqrt(error / num_ratings);
    
end

function [rating] = predict_rounded(user, movie)
% Given the column vectors for a user and a movie, returns the predicated
%   rating as valid integer
    rating = round(predict(user, movie));
    if rating < 1
        rating = 1;
    elseif rating > 5
        rating = 5;
    end
end
