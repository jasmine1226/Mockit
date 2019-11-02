class IntervieweesController < ApplicationController
    def new
        @interviewee = Interviewee.new
    end

    def create
        @interviewee = Interviewee.new(interviewee_params)
        @interviewee.id = SecureRandom.uuid
        if @interviewee.save
            redirect_to interviewee_path(@interviewee)
        else
            redirect_to new_interviewee_path
        end
    end

    def show
        if !@interviewee = Interviewee.find_by_id(params[:id])
            redirect_to interviewees_path
        end
    end

    
    def index
        @interviewees = Interviewee.all
    end

    private

    def interviewee_params
        params.require(:interviewee).permit(:name, :email, :password, :uid, :image, :job_title, :job_level, :experience, :balance)
    end
end
