class CreateInterviewees < ActiveRecord::Migration[6.0]
  def change
    create_table :interviewees, id: :uuid do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :uid
      t.string :image
      t.string :job_title
      t.string :job_level
      t.integer :experience
      t.integer :balance, default: 0

      t.timestamps
    end
  end
end
