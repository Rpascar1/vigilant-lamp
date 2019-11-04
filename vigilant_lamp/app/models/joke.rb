# frozen_string_literal: true

class Joke < ActiveRecord::Base
  belongs_to :user

  validates :status, presence: true
  validates :body, presence: true
  validates :name, presence: true

end
