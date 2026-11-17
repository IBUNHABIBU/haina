class TvPanel < ApplicationRecord
  belongs_to :tv_brand
  belongs_to :tv_size
  belongs_to :customer
end
