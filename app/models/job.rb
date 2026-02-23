class Job < ApplicationRecord
  # Associations
  belongs_to :maker
  belongs_to :owner, class_name: "User"
  has_many :work_logs, dependent: :destroy
  has_many :material_usages, dependent: :destroy
  has_many :job_photos, dependent: :destroy
  has_many :job_histories, dependent: :destroy

  # Validations
  validates :status, presence: true, inclusion: { in: %w[draft in_progress completed cancelled] }
  validates :job_serial, uniqueness: true, allow_nil: true

  # Scopes
  scope :active, -> { where(deleted_at: nil) }
  scope :deleted, -> { where.not(deleted_at: nil) }
  scope :draft, -> { where(status: "draft") }
  scope :in_progress, -> { where(status: "in_progress") }
  scope :completed, -> { where(status: "completed") }
  scope :cancelled, -> { where(status: "cancelled") }

  # Callbacks
  before_create :generate_job_serial

  # Soft delete
  def soft_delete
    update(deleted_at: Time.current)
  end

  def deleted?
    deleted_at.present?
  end

  private

  def generate_job_serial
    return if job_serial.present?

    date_prefix = Time.current.strftime("%Y%m%d")
    last_job = Job.where("job_serial LIKE ?", "#{date_prefix}%").order(job_serial: :desc).first

    if last_job
      sequence = last_job.job_serial[-4..-1].to_i + 1
    else
      sequence = 1
    end

    self.job_serial = "#{date_prefix}#{sequence.to_s.rjust(4, '0')}"
  end
end
