# app/models/activity.rb
class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :customer, optional: true
  belongs_to :tv_brand, optional: true
  belongs_to :tv_size, optional: true
  belongs_to :tatizo, optional: true

  has_many :activity_spares, dependent: :destroy
  has_many :spares, through: :activity_spares
  has_many :repair_returns, dependent: :destroy
  has_many :spare_requests, dependent: :destroy

  has_one_attached :pattern_image
  has_one_attached :model_image
  has_one_attached :board_image
  has_one_attached :tcon_image
  has_one_attached :cof_image
  has_one_attached :panel_image
  has_one_attached :image_before
  has_one_attached :image_after
  has_one_attached :kabla
  has_one_attached :baada

  validates :customer, presence: { message: "Tafadhali chagua jina mteja" }
  validates :tv_brand, presence: { message: "Tafadhali chagua aina ya TV" }
  validates :tv_size, presence: { message: "Tafadhali chagua ukubwa wa TV" }

  has_paper_trail

  enum :status, {
    received: 0,
    diagnosing: 1,
    waiting_for_parts: 2,
    in_repair: 3,
    completed: 4,
    delivered: 5,
    returned: 6,
    irreparable: 7,
    cancelled: 8,
    spare_requested: 9
  }

  before_validation :calculate_gross_profit

  validates :price, :labour_charge, numericality: { greater_than_or_equal_to: 0 }

  scope :sales, -> { where(status: %i[completed delivered returned]) }
  scope :with_balance, -> { where("starting_price > price AND price >= 0") }
  scope :owed, -> {
    where("starting_price > price AND price >= 0 AND status NOT IN (?)",
          [statuses[:cancelled], statuses[:irreparable]])
  }

  scope :search, ->(q) {
    next all if q.blank?

    q_str = q.to_s.strip
    pattern = "%#{sanitize_sql_like(q_str)}%"

    status_values = statuses.keys
      .select { |s| s.include?(q_str.downcase) }
      .map    { |s| statuses[s] }

    conditions = [
      "customers.name ILIKE :q",
      "customers.phone ILIKE :q",
      "tv_brands.name ILIKE :q",
      "CAST(tv_sizes.size AS TEXT) LIKE :q",
      "tatizos.name ILIKE :q",
      "activities.model_no ILIKE :q",
      "activities.board_number ILIKE :q",
      "activities.tcon_number ILIKE :q",
      "activities.cof_number ILIKE :q",
      "activities.panel_number ILIKE :q"
    ]

    bindings = { q: pattern }

    if status_values.any?
      conditions << "activities.status IN (:status_values)"
      bindings[:status_values] = status_values
    end

    left_joins(:customer, :tv_brand, :tv_size, :tatizo)
      .where(conditions.join(" OR "), bindings)
      .distinct
  }

  def spare_cost
    if activity_spares.loaded?
      activity_spares.sum { |item| item.total_cost.to_d }
    else
      activity_spares.sum(:total_cost).to_d
    end
  end

  def gross_profit_value
    price.to_d - labour_charge.to_d - spare_cost
  end

  def recalculate_gross_profit!
    update_columns(
      gross_profit: gross_profit_value,
      updated_at: Time.current
    )
  end

  def calculate_gross_profit
    self.gross_profit = gross_profit_value
  end

  def job_number
    brand = tv_brand&.name.presence || "TV"
    size = tv_size&.size&.to_i

    "#{brand}#{size}-#{created_at.strftime('%H%M')}-#{created_at.strftime('%d%b%y')}E#{id}"
  end

  def info
    helpers = ApplicationController.helpers

    helpers.safe_join([
    helpers.content_tag(:span, "TN##{tcon_number}", class: "text-blue-600 font-semibold"),
    " - ",
    helpers.content_tag(:span, "P##{panel_number}", class: "text-green-600 font-semibold"),
    " - ",
    helpers.content_tag(:span, "C##{cof_number}", class: "text-orange-600 font-semibold")
    ])
  end

  # ============================================================
  # MTTR (Mean Time To Repair)
  # ============================================================

  # MTTR kwa sekunde (Float)
  def mttr_seconds
    return nil unless completed_or_delivered?
    return nil unless date_in.present?
    return nil unless completed_at.present?

    (completed_at - date_in)
  end

  # MTTR kwa masaa (Float) — kwa graph
  def mttr_hours
    return nil unless mttr_seconds
    mttr_seconds / 1.hour
  end

  # MTTR kwa siku (Float) — kwa reference
  def mttr_days
    return nil unless mttr_seconds
    mttr_seconds / 1.day
  end

  # MTTR formatted (English, kwa view):
  # - "45 mins"
  # - "2 hrs 30 mins"
  # - "10 days 10 hrs 5 mins"
  def mttr_display
    seconds = mttr_seconds
    return "—" if seconds.nil? || seconds <= 0

    total_minutes = (seconds / 60).round
    total_hours = total_minutes / 60
    total_days  = total_hours / 24

    days    = total_days
    hours   = total_hours % 24
    mins    = total_minutes % 60

    parts = []
    parts << "#{days} #{days == 1 ? 'day' : 'days'}" if days.positive?
    parts << "#{hours} #{hours == 1 ? 'hr' : 'hrs'}" if hours.positive?
    parts << "#{mins} #{mins == 1 ? 'min' : 'mins'}" if mins.positive?

    return "< 1 min" if parts.empty?
    parts.join(" ")
  end

   # DURATION — muda wa TV kukaa workshop (kutoka date_in hadi sasa)
  # Inatumika kwa TV ZOTE (hata zisizokamilika)
  # ============================================================
  def duration_seconds
    return nil unless date_in.present?
    Time.current - date_in
  end

  def duration_hours
    return nil unless duration_seconds
    duration_seconds / 1.hour
  end

  def duration_days
    return nil unless duration_seconds
    duration_seconds / 1.day
  end

  # Formatted: "3 days 4 hrs 30 mins"
  def duration_display
    seconds = duration_seconds
    return "—" if seconds.nil? || seconds <= 0

    total_minutes = (seconds / 60).round
    total_hours   = total_minutes / 60
    total_days    = total_hours / 24

    days  = total_days
    hours = total_hours % 24
    mins  = total_minutes % 60

    parts = []
    parts << "#{days} #{days == 1 ? 'day' : 'days'}" if days.positive?
    parts << "#{hours} #{hours == 1 ? 'hr' : 'hrs'}" if hours.positive?
    parts << "#{mins} #{mins == 1 ? 'min' : 'mins'}" if mins.positive?

    return "< 1 min" if parts.empty?
    parts.join(" ")
  end

  # Helper ya kuangalia kama activity imekamilika
  def completed_or_delivered?
    completed? || delivered?
  end

  # ============================================================
  # IRREPARABLE REASONS
  # ============================================================
  IRREPARABLE_REASONS = [
    "Repair error",
    "Requires laser",
    "Part unavailable",
    "Glass cracked",
    "Panel damaged",
    "Other"
  ].freeze

  validates :irreparable_reason, presence: true, if: :irreparable?

  private

  def set_completed_at
    if completed? || delivered?
      self.completed_at ||= Time.current
    else
      self.completed_at = nil
    end
  end

  def must_have_at_least_one_cof_image
    unless pattern_image.attached? || cof_image.attached?
      errors.add(:base, "Tafadhali upload angalau picha moja ya Side COF au Main COF")
    end
  end
end