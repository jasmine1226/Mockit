class IntervieweesController < ApplicationController
    def new
        @interviewee = Interviewee.new
    end

    def create
        @interviewee = Interviewer.new(interviewee_params)
        if @interviewee.save
            redirect_to interviewee_path(@interviewee)
        else
            redirect_to new_interviewee_path
        end
    end

    def show
        @interviewee = Interviewee.find_by(params[:id])
    end

    private

    def interviewee_params
        params.require(:interviewee).permit(:name, :email, :password_digest, :uid, :image, :job_title, :job_level, :experience, :balance)
    end
end
