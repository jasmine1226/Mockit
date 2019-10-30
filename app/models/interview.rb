class Interview < ApplicationRecord
    belongs_to :interviewer
    belongs_to :interviewee
end
