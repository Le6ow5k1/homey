class CreateProjects < ActiveRecord::Migration[7.1]
  def change
    create_enum :project_status, %w[open in_progress completed on_hold]

    create_table :projects do |t|
      t.string :name, null: false
      t.text :description
      t.enum :status, enum_type: :project_status, default: 'open', null: false

      t.timestamps
    end
  end
end 