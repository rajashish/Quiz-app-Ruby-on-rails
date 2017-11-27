class LeaderboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @genres = Genre.all
  end

  def getsubgenres
    @genre = Genre.find_by_name(params[:genre])
    render json: @genre.subgenres
  end

  def update  
    if params[:genre] == "All"
      @rels = UserQuiz.all
      @users = User.all
      @arr = Array.new
     
      @users.each do |u|
        @rel = @rels.where(:user => u)
        # if @rel.any?
          @hash = Hash.new
          @hash[:user] = u.email
          @sco = 0
          @rel.each do |r|
            @sco = @sco+ r.score
          end
          @hash[:score] = @sco
          @arr.push(@hash)
        # end
      end
      render json: @arr.sort_by! { |hsh| hsh[:score] }.reverse!

    elsif params[:subgenre] == "All"
      @arr = Array.new
      @users = User.all
      @users.each do |u|
        @genre = Genre.find_by_name(params[:genre])
        @subgs = u.subgenres.where(:genre => @genre)
        @sco = 0
        @subgs.each do |subg|
          puts u
          @rel = u.user_quizs.where(:subgenre_id => subg.id)
          @rel.each do |r|
            @sco += r.score
          end
        end
        @hash = Hash.new
        @hash[:user] = u.email
        @hash[:score] = @sco
        @arr.push(@hash)
      end
      render json: @arr.sort_by! { |hsh| hsh[:score] }.reverse!

    else
      @arr = Array.new
      @users = User.all
      @genre = Genre.find_by_name(params[:genre])
      @subgenre = @genre.subgenres.find_by_name(params[:subgenre])
      @rels = @subgenre.user_quizs
      @users.each do |u|
        @rel = @rels.where(:user => u)
        # if @rel.any?
          @hash = Hash.new
          @hash[:user] = u.email
          @sco = 0
          @rel.each do |r|
            @sco += r.score
          end
          @hash[:score] = @sco
          @arr.push(@hash)
        # end
      end
      render json: @arr.sort_by! { |hsh| hsh[:score] }.reverse!
    end
  end
end