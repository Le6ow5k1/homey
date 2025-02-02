class Comment < ApplicationRecord
  belongs_to :project
  belongs_to :user
  
  validates :content, presence: true
  
  def event_type
    'comment'
  end
end 