class StatusChange < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_one :activity, as: :subject, dependent: :destroy

  validates :previous_status, :new_status, presence: true
  validate :status_actually_changed

  def event_type
    'status_change'
  end

  private

  def status_actually_changed
    return unless previous_status == new_status

    errors.add(:new_status, 'must be different from the previous status')
  end
end
