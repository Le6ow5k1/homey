class CreateProjectActivities < ActiveRecord::Migration[7.1]
  def change
    create_enum :activity_subject_type, ["Comment", "StatusChange"]

    create_table :project_activities do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.enum :subject_type, enum_type: :activity_subject_type, null: false
      t.bigint :subject_id, null: false

      t.timestamps
    end

    add_index :project_activities, [:subject_type, :subject_id]
    add_index :project_activities, [:project_id, :created_at]
  end
end 