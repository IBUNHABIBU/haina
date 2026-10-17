class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :customer, optional: true
  belongs_to :tv_brand, optional: true
  belongs_to :tv_size, optional: true
  belongs_to :tatizo, optional: true

  has_many :activity_spares, dependent: :destroy
  has_many :spares, through: :activity_spares
  has_many :repair_returns, dependent: :destroy

  has_one_attached :pattern_image
  has_one_attached :model_image
  has_one_attached :board_image
  has_one_attached :tcon_image
  has_one_attached :cof_image
  has_one_attached :panel_image
  has_one_attached :image_before
  has_one_attached :image_after

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
    cancelled: 8
  }

  before_validation :calculate_gross_profit

  validates :price, :labour_charge, numericality: { greater_than_or_equal_to: 0 }

  scope :sales, -> { where(status: %i[completed delivered returned]) }

  # ============================================================
  # SEARCH — inatafuta kwenye customer, TV, problem, status,
  # na technical numbers (model, board, tcon, cof, panel)
  # ============================================================
    scope :search, ->(q) {
      next all if q.blank?

      q_str = q.to_s.strip
      pattern = "%#{sanitize_sql_like(q_str)}%"

      # Match enum statuses kwa jina
      status_values = statuses.keys
        .select { |s| s.include?(q_str.downcase) }
        .map    { |s| statuses[s] }

      conditions = [
        "customers.name ILIKE :q",
        "customers.phone ILIKE :q",
        "tv_brands.name ILIKE :q",
        "CAST(tv_sizes.size AS TEXT) LIKE :q",   # ← cast hapa
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
    activity_spares.sum(:total_cost).to_d
  end

  def gross_profit_value
    price.to_d - labour_charge.to_d - spare_cost
  end

  def calculate_gross_profit
    self.gross_profit = gross_profit_value
  end
end