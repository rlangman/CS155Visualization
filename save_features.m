function [] = save_features(users, movies)
% Saves the user and movie features into a text file that can be easily
%   reloaded later.
    
    global users_file;
    global movies_file;
    global num_features;

    formatSpec = [repmat('%f\t',1,num_features) '\n'];
    
    fileID = fopen(users_file, 'w');
    fprintf(fileID, formatSpec, users);
    fclose(fileID);
    
    fileID = fopen(movies_file, 'w');
    fprintf(fileID, formatSpec, movies);
    fclose(fileID);

end

