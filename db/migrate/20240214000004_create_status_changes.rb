class CreateStatusChanges < ActiveRecord::Migration[7.1]
  def change
    create_table :status_changes do |t|
      t.references :project, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.enum :previous_status, enum_type: :project_status, null: false
      t.enum :new_status, enum_type: :project_status, null: false
      t.text :change_reason

      t.timestamps
    end

    add_index :status_changes, [:project_id, :created_at]
  end
end 