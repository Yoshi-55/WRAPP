class Maker < ApplicationRecord
  # Associations
  has_many :jobs, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true, uniqueness: true

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
