class Project < ApplicationRecord
  has_many :comments
  has_many :status_changes
  has_many :activities, class_name: 'ProjectActivity'
  
  validates :name, presence: true
  validates :status, presence: true

  enum status: {
    open: 'open',
    in_progress: 'in_progress',
    on_hold: 'on_hold',
    completed: 'completed'
  }, _prefix: true
end 