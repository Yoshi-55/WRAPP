class Material < ApplicationRecord
  # Associations
  has_many :material_usages, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true
  validates :unit, presence: true, inclusion: { in: %w[m m2 枚] }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :width_mm, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  # Scopes
  scope :active, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }

  # Soft delete
  def soft_delete
    update(deleted_at: Time.current)
  end

  def deleted?
    deleted_at.present?
  end
end
