class InterviewsController < ApplicationController
    def new
        @interview = Interview.new
    end

    def create
        @interview = Interview.new(interview_params)
        @interview.interviewee_id = session[:id]
        @interview.cost_calc

        if @interview.process_payment
            @interview.save            
            redirect_to interview_path(@interview)
        else
            @interviewee = Interviewee.find_by_id(session[:id])
            render :low_balance
        end
    end

    def show
        @interview = Interview.find_by_id(params[:id])
    end

    private

    def interview_params
        params.require(:interview).permit(:interviewer_id, :interviewee_id, :interview_type, :date, :time, :length, :cost)
    end
end
