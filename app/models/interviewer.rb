class Interviewer < ApplicationRecord
    has_many :interviews
    has_many :interviewees, through: :interviews
    has_secure_password
    validates :email, uniqueness: true
    validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
    belongs_to :company    
    accepts_nested_attributes_for :company

    include Filterable       
    scope :active, -> { where is_active: true }

    def company_attributes=(company)
        self.company = Company.find_or_create_by(name: company[:name])
        self.company.update(company)
    end

end
