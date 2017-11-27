class UserQuiz < ApplicationRecord
  belongs_to :user
  belongs_to :subgenre
end
