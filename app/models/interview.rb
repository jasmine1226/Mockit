class Interview < ApplicationRecord
    belongs_to :interviewer
    belongs_to :interviewee

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
end
