class InterviewersController < ApplicationController
    def new
        @interviewer = Interviewer.new
    end

    def create
        @interviewer = Interviewer.new(interviewer_params)
        if @interviewer.save
            redirect_to interviewer_path(@interviewer)
        else
            redirect_to new_interviewer_path
        end
    end

    def show
        @interviewer = Interviewer.find(params[:id])
    end

    def index
        @interviewers = Interviewer.all
    end

    private

    def interviewer_params
        params.require(:interviewer).permit(:name, :email, :password, :uid, :image, :job_title, :job_level, :experience, :is_manager, :is_active, :rate)
    end
end
