function [users, movies] = load_features()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    global users_file;
    global movies_file;
    global num_features;
    global num_users;
    global num_movies;

    formatSpec = [repmat('%f\t',1,num_features) '\n'];
    
    fileID = fopen(users_file, 'r');
    sizeA = [num_features, num_users];
    users = fscanf(fileID, formatSpec, sizeA);
    fclose(fileID);
    
    fileID = fopen(movies_file, 'r');
    sizeA = [num_features, num_movies];
    movies = fscanf(fileID, formatSpec, sizeA);
    fclose(fileID);

end