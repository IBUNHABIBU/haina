
class SpareRequest < ApplicationRecord
  belongs_to :activity, optional: true
  belongs_to :spare, optional: true
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

  validate :activity_required_for_activity_request
  validate :issued_quantity_cannot_exceed_requested

  SPARE_TYPES = {
  "motherboard" => "Motherboard",
  "tcon" => "T-Con",
  "power_supply" => "Power Supply",
  "side cof" => "Side COF",
  "main cof" => "Main COF",
  "backlight" => "Backlight"
  }.freeze

  validates :spare_type,
            inclusion: { in: SPARE_TYPES.keys },
            if: :activity?

  before_validation :assign_requested_part_number, if: :activity?

  validate :required_activity_part_number, if: :activity?

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

  def assign_requested_part_number
  return unless activity

  self.requested_part_number =
    case spare_type
    when "motherboard"
      activity.board_number.presence
    when "tcon"
      activity.tcon_number.presence
    when "main cof"
      activity.cof_number.presence
    when "side cof"
    activity.side_cof_number.presence
    when "power_supply", "backlight"
      nil
    end
end

def required_activity_part_number
    return unless activity
    return unless %w[motherboard tcon cof].include?(spare_type)

    if requested_part_number.blank?
      errors.add(
        :requested_part_number,
        "must be entered in the Activity before requesting this spare"
      )
    end
  end
end
