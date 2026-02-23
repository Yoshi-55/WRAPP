class JobPhoto < ApplicationRecord
  # Associations
  belongs_to :job

  # Validations
  validates :photo_type, presence: true, inclusion: { in: %w[before during after] }

  # Scopes
  scope :active, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }
  scope :before_photos, -> { where(photo_type: "before") }
  scope :during_photos, -> { where(photo_type: "during") }
  scope :after_photos, -> { where(photo_type: "after") }
  scope :ordered, -> { order(sort_order: :asc, created_at: :asc) }

  # Soft delete
  def soft_delete
    update(deleted_at: Time.current)
  end

  def deleted?
    deleted_at.present?
  end
end
