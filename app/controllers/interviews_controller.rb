class InterviewsController < ApplicationController
    before_action :require_login
    before_action :is_interviewee, only: [:new, :create]

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
            redirect_to interview_path(@interview), notice: "Interview booking cofirmed. Account Balance: $#{Interviewee.find_by_id(session[:id]).balance}"
        else
            @interviewee = Interviewee.find_by_id(session[:id])
            render :low_balance
        end
    end

    def index
        if session[:account_type] == "Interviewer"
            @interviews = Interview.all.where("interviewer_id = ?", session[:id])
            @interviews = @interviews.interviewee(Interviewee.find(params[:interviewee_id])) if params[:interviewee_id]
        elsif session[:account_type] == "Interviewee"
            @interviews = Interview.all.where("interviewee_id = ?", session[:id])
            @interviews = @interviews.interviewer(Interviewer.find(params[:interviewer_id])) if params[:interviewer_id]
        end
    end

    def show
        @interview = Interview.find_by_id(params[:id])
    end

    private

    def interview_params
        params.require(:interview).permit(:interviewer_id, :interviewee_id, :interview_type, :date, :time, :length, :cost)
    end

    def is_interviewee
        return head(:forbidden) unless session[:account_type] == "Interviewee"
    end
end
