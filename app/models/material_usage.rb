class MaterialUsage < ApplicationRecord
  # Associations
  belongs_to :job
  belongs_to :material

  # Validations
  validates :used_length_m, numericality: { greater_than_or_equal_to: 0 }
  validates :waste_length_m, numericality: { greater_than_or_equal_to: 0 }

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

  # Total length used (including waste)
  def total_length
    (used_length_m || 0) + (waste_length_m || 0)
  end
end
