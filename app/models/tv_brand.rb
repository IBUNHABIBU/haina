class TvBrand < ApplicationRecord
  include PreventDestroyIfAssociated
  has_many :activities, dependent: :restrict_with_error
  
  prevent_destroy_if_associated :activities
end
