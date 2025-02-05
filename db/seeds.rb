# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create test user
user = User.first_or_create!(
  name: 'Test User',
  email: 'test@example.com'
)

# Create sample projects
projects = [
  {
    name: 'Website Redesign',
    description: 'Complete overhaul of the company website with modern design and improved UX',
    status: 'in_progress'
  },
  {
    name: 'Mobile App Development',
    description: 'New mobile app for both iOS and Android platforms',
    status: 'open'
  },
  {
    name: 'Database Migration',
    description: 'Migrate legacy database to new cloud infrastructure',
    status: 'completed'
  }
]

projects.each do |project_data|
  project = Project.find_by(name: project_data[:name])
  project ||= Project.create!(project_data)
  
  # Add some sample comments
  project.activities.create!(
    user: user,
    subject: Comment.new(content: 'Initial project setup completed', project: project, user: user)
  )
  
  # Add a status change
  if project.status != 'open'
    project.activities.create!(  
      user: user,
      subject: StatusChange.new(
        previous_status: 'open',
        new_status: project.status,
        change_reason: "Moving project to #{project.status}",
        project: project,
        user: user
      )
    )
  end
end
