class ProjectActivity < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :subject, polymorphic: true

  scope :newest_first, -> { order(created_at: :desc) }

  delegate :content, to: :subject, allow_nil: true
  delegate :previous_status, :new_status, :change_reason, to: :subject, allow_nil: true
end