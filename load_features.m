function [users, movies] = load_features()
% Loads the user and movie features from a text file
    
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