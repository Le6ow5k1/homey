class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user
  has_one :activity, class_name: 'ProjectActivity', as: :subject, dependent: :destroy

  validates :content, presence: true

  def event_type
    'comment'
  end
end
