class InterviewsController < ApplicationController
    def new
        @interview = Interview.new
    end

    def create
        @interview = Interview.new(interview_params)
        @interview.interviewee_id = session[:id]
        @interview.cost_calc
        @interview.process_payment

        if @interview.save
            redirect_to interview_path(@interview)
        else
            redirect_to new_interview_path
        end
    end

    def show
        @interview = Interview.find_by_id(params[:id])
        @interviewer = Interviewer.find_by_id(@interview.interviewer_id)
        @interviewee = Interviewee.find_by_id(@interview.interviewee_id)
    end

    private

    def interview_params
        params.require(:interview).permit(:interviewer_id, :interviewee_id, :interview_type, :date, :time, :length, :cost)
    end
end
