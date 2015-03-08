function [user_devs, movie_devs] = load_devs()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    global user_devs_file;
    global movie_devs_file;
    global num_users;
    global num_movies;

    formatSpec = '%f\n';
    
    fileID = fopen(user_devs_file, 'r');
    sizeA = [1, num_users];
    user_devs = fscanf(fileID, formatSpec, sizeA);
    fclose(fileID);
    
    fileID = fopen(movie_devs_file, 'r');
    sizeA = [1, num_movies];
    movie_devs = fscanf(fileID, formatSpec, sizeA);
    fclose(fileID);

end
