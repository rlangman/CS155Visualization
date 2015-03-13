global num_users;
global num_movies;
global num_ratings;
global num_features;
global lambda;
global eta;
global avg_rating;
global users_file;
global movies_file;
global user_devs_file;
global movie_devs_file;

load_data = true;
save_data = true;
use_devs = false;

users_file = 'users.txt';
movies_file = 'movies.txt';
user_devs_file = 'user_devs.txt';
movie_devs_file = 'movie_devs.txt';

num_users = 943;
num_movies = 1682;
num_ratings = 100000;
num_features = 20;
lambda = 0.01;
eta = 0.005;
avg_rating = 3.5299;
num_epochs = 300;

data_file = 'data.txt';

ratings = parse_movie_data(data_file, num_ratings);
movie_avg = compute_average(ratings);

if load_data
    [users, movies] = load_features();
    if use_devs
        [user_devs, movie_devs] = load_devs();
    end
else
    % Initialize features randomly
    users = randn(num_features, num_users);
    movies = randn(num_features, num_movies);
    if use_devs
        user_devs = randn(num_users, 1);
        movie_devs = randn(num_movies, 1);
    end
end

% Train the features using stochastic gradient descent
%[users, movies] = train_gradient(users, movies, ratings, num_epochs);
%[users, movies, user_devs, movie_devs] = train_gradient_advanced(...
%   users, movies, user_devs, movie_devs, ratings, num_epochs);
[users, movies] = train_als(users, movies, ratings, num_epochs);

if save_data
    save_features(users, movies);
    if use_devs
        save_devs(user_devs, movie_devs);
    end
end
