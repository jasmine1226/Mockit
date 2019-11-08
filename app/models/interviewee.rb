class Interviewee < ApplicationRecord
    has_many :interviews
    has_many :interviewers, through: :interviews
    has_secure_password
    validates :email, uniqueness: true
    validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

    include Filterable
end
