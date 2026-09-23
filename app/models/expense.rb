class Expense < ApplicationRecord
  belongs_to :user, optional: true

  CATEGORIES = %w[spares electricity rent transport tools salaries internet maintenance other].freeze

  validates :category, :description, :amount, :spent_on, presence: true
  validates :category, inclusion: { in: CATEGORIES }
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
