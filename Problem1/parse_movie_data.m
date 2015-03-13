function [ratings] = parse_movie_data(file, num_ratings)
% This function takes a file containing N lines of the form
%   user_id\movie_id\rating and outputs a 3xN matrix with the data

    fileID = fopen(file, 'r');
    formatSpec = '%i\t%i\t%i\n';
    sizeA = [3 num_ratings];
    ratings = fscanf(fileID, formatSpec, sizeA);
    fclose(fileID);

end

