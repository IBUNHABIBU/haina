
class SpareRequest < ApplicationRecord
  belongs_to :activity, optional: true
  belongs_to :spare
  belongs_to :requested_by, class_name: "User"
  belongs_to :issued_by, class_name: "User", optional: true

  enum :request_type, {
    activity: "activity",
    workshop: "workshop",
    stock_replenishment: "stock_replenishment"
  }, validate: true

  enum :status, {
    requested: "requested",
    approved: "approved",
    ordered: "ordered",
    partially_fulfilled: "partially_fulfilled",
    fulfilled: "fulfilled",
    rejected: "rejected",
    cancelled: "cancelled"
  }, validate: true

  validates :requested_quantity,
            numericality: { only_integer: true, greater_than: 0 }

  validates :issued_quantity,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :unit_cost_at_issue,
            numericality: { greater_than_or_equal_to: 0 },
            allow_nil: true

  validates :reason, presence: true

  validate :activity_required_for_activity_request
  validate :issued_quantity_cannot_exceed_requested

  private

  def activity_required_for_activity_request
    if activity? && activity_id.blank?
      errors.add(:activity, "must be selected for an activity request")
    end
  end

  def issued_quantity_cannot_exceed_requested
    return if requested_quantity.blank? || issued_quantity.blank?

    if issued_quantity > requested_quantity
      errors.add(:issued_quantity, "cannot exceed requested quantity")
    end
  end
end
