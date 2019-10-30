class Interviewer < ApplicationRecord
    has_many :interviews
    has_many :interviewees, through: :interviews
    has_secure_password
end
