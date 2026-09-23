class SpareCategory < ApplicationRecord
  has_many :spares, dependent: :restrict_with_error

  validates :name, :code, presence: true
  validates :code, uniqueness: true
end
