class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :owned_jobs, class_name: "Job", foreign_key: "owner_id", dependent: :restrict_with_error
  has_many :work_logs, dependent: :restrict_with_error

  # Validations
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: %w[owner manager worker sys_admin] }

  # Role helpers
  def owner?
    role == "owner"
  end

  def manager?
    role == "manager"
  end

  def worker?
    role == "worker"
  end

  def sys_admin?
    role == "sys_admin"
  end
end
