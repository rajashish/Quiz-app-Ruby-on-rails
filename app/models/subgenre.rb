class Subgenre < ApplicationRecord
  belongs_to :genre
  has_many :questions
  has_many :user_quizs
  has_many :users, :through => :user_quizs
end
