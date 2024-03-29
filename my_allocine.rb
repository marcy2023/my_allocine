requests ={}

# 1. Display all actors
requests['Display all actors'] = "SELECT * FROM actors;"

# 2. Display all genres
requests['Display all genres'] = "SELECT * FROM genres;"

# 3. Display the name and year of the movies
requests['Display the name and year of the movies'] = "SELECT mov_title, mov_year FROM movies " 

# 4. Display reviewer name from the reviews table
requests['Display reviewer name from the reviews table'] = "SELECT rev_name FROM reviews;"

# 5. Find the year when the movie American Beauty was released
requests["Find the year when the movie American Beauty released"] = "SELECT mov_year FROM movies WHERE mov_title = 'American Beauty';"

# 6. Find the movie which was released in the year 1999
requests["Find the movie which was released in the year 1999"] = "SELECT mov_title FROM movies WHERE mov_year = 1999;"

# 7. Find the movie which was released before 1998
requests["Find the movie which was released before 1998"] = "SELECT mov_title FROM movies WHERE mov_year < 1998;"

# 8. Find the name of all reviewers who have rated 7 or more stars to their rating order
requests["Find the name of all reviewers who have rated 7 or more stars to their rating order by reviews rev_name (it might have duplicated names :-))"] = "SELECT rev_name FROM reviews JOIN movies_ratings_reviews ON reviews.id = movies_ratings_reviews.rev_id WHERE rev_stars >= 7 ORDER BY rev_name; "

# 9. Find the titles of the movies with ID 905, 907, 917
requests["Find the titles of the movies with ID 905, 907, 917"] = "SELECT mov_title FROM movies WHERE id IN (905, 907, 917);"

# 10. Find the list of those movies with year and ID which include the words 'Boogie Nights'
requests["Find the list of those movies with year and ID which include the words Boogie Nights"] = "SELECT id, mov_title, mov_year FROM movies WHERE mov_title LIKE '%Boogie Nights%';"

# 11. Find the ID number for the actor whose first name is 'Woody' and the last name is 'Allen'
requests["Find the ID number for the actor whose first name is 'Woody' and the last name is 'Allen'"] = "SELECT id FROM actors WHERE act_fname = 'Woody' AND act_lname = 'Allen';"

# 12. Find the actors with all information who played a role in the movies 'Annie Hall'
requests["Find the actors with all information who played a role in the movies 'Annie Hall'"] = "SELECT DISTINCT actors.* FROM movies JOIN movies_actors ON mov_id = (SELECT id FROM movies WHERE mov_title = 'Annie Hall') JOIN actors ON act_id = actors.id;"

# 13. Find the first and last names of all the actors who were cast in the movies 'Annie Hall', and the roles they played in that production
requests["Find the first and last names of all the actors who were cast in the movies 'Annie Hall', and the roles they played in that production"] = "SELECT act_fname, act_lname, role FROM movies JOIN movies_actors ON mov_id = movies.id JOIN actors ON act_id = actors.id WHERE mov_title = 'Annie Hall';"

# 14. Find the name of the movie and director who directed a movie that casted a role as Sean Maguire
requests["Find the name of movie and director who directed a movies that casted a role as Sean Maguire"] = "SELECT dir_fname, dir_lname, mov_title FROM directors 
RIGHT JOIN directors_movies ON directors.id = directors_movies.dir_id RIGHT JOIN movies_actors ON directors_movies.mov_id = movies_actors.mov_id
RIGHT JOIN movies ON movies.id = movies_actors.mov_id WHERE role = 'Sean Maguire';"

# 15. Find all the actors who have not acted in any movie between 1990 and 2000 (select only actor first name, last name, movie title and release year)
requests["Find all the actors who have not acted in any movie between 1990 and 2000 (select only actor first name, last name, movie title and release year)"] = "SELECT actors.act_fname, actors.act_lname, movies.mov_title, CAST(strftime('%Y', movies.mov_dt_rel) AS INTEGER) as mov_year 
FROM actors INNER JOIN movies_actors ON actors.id = movies_actors.act_id INNER JOIN movies ON movies_actors.mov_id = movies.id WHERE CAST(strftime('%Y', movies.mov_dt_rel) AS INTEGER) NOT BETWEEN 1990 AND 2000 AND actors.act_fname <> 'Kevin' AND actors.act_lname <> 'Spacey';"

class MovieQuery
    def initialize(db_path)
      @db = SQLite3::Database.open(db_path)
    end
  
    def execute(query_description, sql_query)
      puts "Request: #{query_description}"
  
      begin
        @db.execute(sql_query) do |row|
          puts row.join(' | ')
        end
      rescue SQLite3::Exception => e
        raise "Query failed: #{e.message}"
      end
    end
  
    def close
      @db.close
    end
  end
  
  
