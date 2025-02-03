class ProjectActivity < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :subject, polymorphic: true

  validates_associated :subject

  scope :newest_first, -> { order(created_at: :desc) }
end