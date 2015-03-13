% This script loads the movie lens data and runs whatever training
% algorithm is not commented out. The results are the features output
% by the training and, if specified, outputs the features into a text
% file.

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

load_data = false;
save_data = true;
use_devs = true;

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
num_epochs = 500;

% Load the data
data_file = 'data.txt';
ratings = parse_movie_data(data_file, num_ratings);
movie_avg = compute_average(ratings);

% Either load features that were saved from a previous run, or initialize
% them arbitrarily
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

% Train the features using some method...

%[users, movies] = train_gradient(users, movies, ratings, num_epochs);
[users, movies, user_devs, movie_devs] = train_gradient_advanced(...
   users, movies, user_devs, movie_devs, ratings, num_epochs);
%[users, movies] = train_als(users, movies, ratings, num_epochs);

if save_data
    save_features(users, movies);
    if use_devs
        save_devs(user_devs, movie_devs);
    end
end
