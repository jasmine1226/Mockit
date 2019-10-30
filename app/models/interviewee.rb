class Interviewee < ApplicationRecord
    has_many :interviews
    has_many :interviewers, through: :interviews
end
