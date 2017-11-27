Rails.application.routes.draw do
 

  get 'quizplay/index'

  get 'dashboard/index'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get 'home/index'
  root 'home#index'
  devise_for :users
  


get '/quizplay', to: 'quizplay#index'
get '/quizplay/continue', as: 'quizplay_continue'
post '/quizplay/continue', to: 'quizplay#continuepost'
get '/quizplay/:id', to: 'quizplay#show', as: 'quiz_play_by_id'
get '/quizplay/:id/:ques', to: 'quizplay#ques', as: 'quiz_play_by_ques'
  post '/quizplay/:id/:ques', to: 'quizplay#next', as: 'quiz_play_by_next'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
