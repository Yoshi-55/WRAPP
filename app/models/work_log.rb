class WorkLog < ApplicationRecord
  # Associations
  belongs_to :job
  belongs_to :user

  # Validations
  validates :started_at, presence: true
  validate :ended_at_after_started_at

  # Scopes
  scope :active, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }

  # Callbacks
  before_save :calculate_duration

  # Soft delete
  def soft_delete
    update(deleted_at: Time.current)
  end

  def deleted?
    deleted_at.present?
  end

  private

  def calculate_duration
    return unless started_at && ended_at

    self.duration_minutes = ((ended_at - started_at) / 60).to_i
  end

  def ended_at_after_started_at
    return unless started_at && ended_at

    if ended_at < started_at
      errors.add(:ended_at, "は開始時刻より後の時刻を指定してください")
    end
  end
end
