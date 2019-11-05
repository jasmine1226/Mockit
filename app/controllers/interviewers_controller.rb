class InterviewersController < ApplicationController

    def new
        @interviewer = Interviewer.new
    end

    def create
        @interviewer = Interviewer.new(interviewer_params)
        @interviewer.id = SecureRandom.uuid
        if @interviewer.save
            redirect_to interviewer_path(@interviewer)
        else
            render :new
        end
    end

    def show
        if !@interviewer = Interviewer.find_by_id(params[:id])
            redirect_to interviewers_path
        end
    end

    def edit
        @interviewer = Interviewer.new
    end

    def update
        @interviewer = Interviewer.find_by_id(params[:id])
        @interviewer.update(interviewer_params)
        if @interviewer.save
            redirect_to interviewer_path(@interviewer)
        else
            render :edit
        end
    end

    def index
        @interviewers = Interviewer.all
    end

    private

    def interviewer_params
        params.require(:interviewer).permit(:name, :email, :password, :uid, :image, :job_title, :job_level, :experience, :is_manager, :is_active, :rate)
    end

end
