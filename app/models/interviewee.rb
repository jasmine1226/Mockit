class Interviewee < ApplicationRecord
    has_many :interviews
    has_many :interviewers, through: :interviews
    has_secure_password
    validates :email, uniqueness: true
    validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
    validates :experience, numericality: { less_than: 80 }

    def set_fb_attributes(auth)
        self.name = auth['info']['name']
        self.email = auth['info']['email']
        self.image = auth['info']['image']
        self.uid = auth['uid']
        self.password_digest = SecureRandom.urlsafe_base64
        self
    end
end
