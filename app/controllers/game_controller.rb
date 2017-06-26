class GameController < ApplicationController
  def new
    session[:score] = 0
  end

  def search
    search_result = Tmdb::Search.movie(params[:search])
    if search_result.total_results < 1
      #some error
    else
      movie_result = search_result.results[0] #choose most relevant
      movie_cast = Tmdb::Movie.cast(movie_result.id)

      #pick top 5 billed
      movie_cast = movie_cast.slice(0, 5)

      @images = movie_cast.map do |person|
        profile_image_url(person.profile_path)
      end

      ordered_names = movie_cast.map do |person|
        person.name
      end

      @names = ordered_names.shuffle

      answer_key = Hash.new

      movie_cast.each_with_index do |person, idx|
        answer_key[person.name] = idx + 1
      end
      session[:answer_key] = answer_key
    end

    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  def submit
    @answers = session[:answer_key]
    @values = params[:answer].sort { |x, y| x[:number] <=> y[:number] }

    @correct_answers = session[:score]
    @values.each do |value|
      if (@answers[value[:name]].to_s == value[:number].to_s)
        @correct_answers = @correct_answers + 1
      end
    end

    session[:score] = @correct_answers

    respond_to do |format|
      format.html
      format.js
      format.json
    end

  end

  private
    def profile_image_url(image_path)
      config = Tmdb::Configuration.get
      config.images.base_url + config.images.profile_sizes[1] + image_path
    end
end
