class InterviewsController < ApplicationController
    before_action :require_login

    def new
        @interview = Interview.new
        @interview.interviewer = Interviewer.find_by_id(params[:interviewer_id]) if params[:interviewer_id]
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

    def index
        if session[:account_type] == "Interviewer"
            @interviews = Interview.all.where("interviewer_id = ?", session[:id]).interviewee(Interviewee.find(params[:interviewer_id]))
        elsif session[:account_type] == "Interviewee"
            @interviews = Interview.all.where("interviewee_id = ?", session[:id]).interviewer(Interviewer.find(params[:interviewer_id]))
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
