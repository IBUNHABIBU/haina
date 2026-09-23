class Customer < ApplicationRecord
  belongs_to :user
  has_many :activities, dependent: :restrict_with_error
end
