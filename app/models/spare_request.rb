class SpareRequest < ApplicationRecord
  belongs_to :activity
  belongs_to :spare
  belongs_to :requested_by
  belongs_to :issued_by
end
