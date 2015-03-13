function [avg] = compute_average(ratings)
% Given a list of ratings, computes the average rating for each user and
%   movie
    global num_ratings;
    
    avg = 0.0;

    % Get the sums and counts
    for i=1:num_ratings
        [u, m, r] = get_rating_info(ratings(:, i));
        avg = avg + r;
    end
    
    % Take the average
    avg = avg / num_ratings;

end

