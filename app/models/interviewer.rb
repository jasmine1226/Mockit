class Interviewer < ApplicationRecord
    has_many :interviews
    has_many :interviewees, through: :interviews
    has_secure_password
    validates :email, uniqueness: true
    validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
    belongs_to :company    
    accepts_nested_attributes_for :company
    validates :experience, numericality: { less_than: 80 }
    validates :rate, numericality: { less_than: 10000 }

    include Filterable       
    scope :active, -> { where is_active: true }
    scope :job_title, -> (job_title) { where job_title: job_title }
    scope :job_level, -> (job_level) { where job_level: job_level}  
    scope :experience, -> (experience) { where("experience >= ?", experience) }
    scope :is_manager, -> (is_manager) { where is_manager: is_manager}    
    scope :company_id, -> (company_id) { where company_id: company_id}

    def company_attributes=(company)
        self.company = Company.find_or_create_by(name: company[:name])
        self.company.update(company)
    end

    def set_fb_attributes(auth)
        self.uid = auth['uid']
        self.name = auth['name']
        self.email = auth['email']
        self.image = auth['image']
        self.password_digest = SecureRandom.urlsafe_base64
        self
    end
end
