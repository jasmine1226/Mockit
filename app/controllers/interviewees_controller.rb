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
            render :new
        end
    end

    def show
        if !@interviewee = Interviewee.find_by_id(params[:id])
            redirect_to interviewees_path
        end
    end

    def edit
        @interviewee = Interviewee.new
    end

    def update
        @interviewee = Interviewee.find_by_id(params[:id])
        @interviewee.update(interviewee_params)
        if @interviewee.save
            redirect_to interviewee_path(@interviewee)
        else
            render :edit
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
