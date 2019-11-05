class CreateInterviewers < ActiveRecord::Migration[6.0]
  def change
    create_table :interviewers do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :uid
      t.string :image
      t.string :job_title
      t.string :job_level
      t.integer :experience
      t.boolean :is_manager
      t.boolean :is_active, default: true
      t.integer :rate

      t.timestamps
    end
  end
end
