class Project < ApplicationRecord
  has_many :comments
  has_many :status_changes
  
  validates :name, presence: true
  validates :status, presence: true

  enum status: {
    open: 'open',
    in_progress: 'in_progress',
    on_hold: 'on_hold',
    completed: 'completed'
  }, _prefix: true

  def conversation_history(page: 1, per_page: 10)
    events = (comments + status_changes)
      .sort_by(&:created_at)
      .reverse

    total_pages = (events.length.to_f / per_page).ceil
    start_idx = (page - 1) * per_page
    
    {
      events: events[start_idx, per_page] || [],
      current_page: page,
      total_pages: total_pages
    }
  end
end 