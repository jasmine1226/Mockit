class CreateInterviews < ActiveRecord::Migration[6.0]
  def change
    create_table :interviews, id: :uuid  do |t|
      t.string :interviewer_id
      t.string :interviewee_id
      t.string :interview_type, default: "Virtual"
      t.date :date
      t.time :time
      t.integer :length
      t.integer :cost

      t.timestamps
    end
  end
end
