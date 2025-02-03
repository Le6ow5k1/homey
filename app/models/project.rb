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

  def activity_feed(page: 1, per_page: 10)
    page = [page.to_i, 1].max
    offset_value = (page - 1) * per_page
    total_count = activities.count
    
    {
      activities: activities.newest_first
                          .includes(subject: [:user])
                          .limit(per_page)
                          .offset(offset_value),
      current_page: page,
      total_pages: (total_count.to_f / per_page).ceil
    }
  end
end 