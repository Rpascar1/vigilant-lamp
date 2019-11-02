# frozen_string_literal: true

class Joke < ActiveRecord::Base
  belongs_to :user
end
