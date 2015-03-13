function [] = save_devs(user_devs, movie_devs)
% Saves the user and movie biases into a text file that can be easily
%   reloaded later.
    
    global user_devs_file;
    global movie_devs_file;

    formatSpec = '%f\n';
    
    fileID = fopen(user_devs_file, 'w');
    fprintf(fileID, formatSpec, user_devs);
    fclose(fileID);
    
    fileID = fopen(movie_devs_file, 'w');
    fprintf(fileID, formatSpec, movie_devs);
    fclose(fileID);

end