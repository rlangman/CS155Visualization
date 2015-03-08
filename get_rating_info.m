function [user_id, movie_id, rating] = get_rating_info(rating_col)
% Given a column representing a rating, returns the user_id, movie_id, and
%   rating value
    user_id = rating_col(1); % First entry is the user index
    movie_id = rating_col(2); % Second is movie index
    rating = rating_col(3); % Third is the actual rating

end

