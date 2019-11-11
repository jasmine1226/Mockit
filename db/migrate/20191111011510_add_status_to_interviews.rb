class AddStatusToInterviews < ActiveRecord::Migration[6.0]
  def change
    add_column :interviews, :status, :string, default: "Scheduled"
  end
end
