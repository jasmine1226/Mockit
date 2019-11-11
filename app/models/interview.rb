class Interview < ApplicationRecord
    belongs_to :interviewer
    belongs_to :interviewee
    validates :interviewer_id, :interviewee_id, :date, :time, :length, presence: true
    validate :future_date, :on => :create

    scope :interviewer, -> (interviewer_id) { where interviewer_id: interviewer_id }    
    scope :interviewee, -> (interviewee_id) { where interviewee_id: interviewee_id }

    def future_date
        if date <= Date.today
            errors.add(:date, "You cannot schedule an interview on the same day or in the past.")
        end
    end

    def cost_calc
        interviwer = Interviewer.find_by_id(self.interviewer_id)
        self.cost = interviewer.rate * self.length
    end

    def process_payment
        interviwee = Interviewee.find_by_id(self.interviewee_id)
        if interviewee.balance >= self.cost
            interviewee.balance -= self.cost
            interviewee.save
        end
    end

    def status
        datetime = self.date + self.time.seconds_since_midnight.seconds
        if datetime < DateTime.now
            self.status = "Completed"
        else
            self.status = "Scheduled"
        end
    end
end
