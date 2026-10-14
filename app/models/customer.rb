class Customer < ApplicationRecord
  validates :name, presence: true,  uniqueness: { case_sensitive: false }
  belongs_to :user
  has_many :activities, dependent: :restrict_with_error
end
