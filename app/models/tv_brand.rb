class TvBrand < ApplicationRecord
  has_many :activities, dependent: :restrict_with_error
end
