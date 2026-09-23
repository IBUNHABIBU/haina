class RepairReturn < ApplicationRecord
  belongs_to :activity

  STATUSES = %w[received investigating repairing completed returned_to_customer].freeze

  validates :return_number, :returned_at, :location, :reason, :status, presence: true
  validates :status, inclusion: { in: STATUSES }

  before_validation :assign_return_number, on: :create
  after_create :increment_activity_return_count

  private

  def assign_return_number
    return if return_number.present?
    self.return_number = activity.repair_returns.maximum(:return_number).to_i + 1
  end

  def increment_activity_return_count
    activity.increment!(:returned_count)
  end
end
