class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_one :activity, as: :subject, dependent: :destroy

  validates :content, presence: true

  def event_type
    'comment'
  end
end
