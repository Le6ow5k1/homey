class Project < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :status_changes, dependent: :destroy
  has_many :activities, class_name: 'ProjectActivity', dependent: :destroy

  validates :name, presence: true
  validates :status, presence: true

  enum :status, {
    open: 'open',
    in_progress: 'in_progress',
    on_hold: 'on_hold',
    completed: 'completed'
  }, prefix: true
end
