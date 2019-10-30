class Interviewer < ApplicationRecord
    has_many :interviews
    has_many :interviewees, through: :interviews
end
