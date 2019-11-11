class AddCompanyIdsToInterviewers < ActiveRecord::Migration[6.0]
  def change
    add_column :interviewers, :company_id, :integer
  end
end
