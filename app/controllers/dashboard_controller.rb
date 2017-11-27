class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @sum = 0
    current_user.user_quizs.each do |qt|
      @sum =@sum + qt.score
    end
    current_user.score = @sum
    current_user.save
    @quizes = current_user.user_quizs
  end
end