class Interview < ApplicationRecord
    belongs_to :interviewer
    belongs_to :interviewee

    include Filterable
    scope :interviewer_id, -> (interviewer_id) { where interviewer_id: interviewer_id }    
    scope :interviewee_id, -> (interviewee_id) { where interviewee_id: interviewee_id }


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
        datetime = self.date + Time.parse("16:30").seconds_since_midnight.seconds
        if datetime < DateTime.now
            "Completed"
        else
            "Scheduled"
        end
    end
end
