class JobHistory < ApplicationRecord
  # Associations
  belongs_to :job

  # Validations
  validates :action_type, presence: true, inclusion: { in: %w[created started completed modified reopened] }

  # Scopes
  scope :active, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }
  scope :ordered, -> { order(created_at: :desc) }

  # Soft delete
  def soft_delete
    update(deleted_at: Time.current)
  end

  def deleted?
    deleted_at.present?
  end
end
