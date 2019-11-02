class InterviewersController < ApplicationController
    #before_create :generate_random_id
    
    def new
        @interviewer = Interviewer.new
    end

    def create
        @interviewer = Interviewer.new(interviewer_params)
        @interviewer.id = SecureRandom.uuid
        if @interviewer.save
            redirect_to interviewer_path(@interviewer)
        else
            raise params.inspect
            #redirect_to new_interviewer_path
        end
    end

    def show
        #if params[:id].to_i < 1 || params[:id].to_i > Interviewer.all.length
        #    redirect_to interviewers_path
        #else
            @interviewer = Interviewer.find_by_id(params[:id])
        #end
    end

    def index
        @interviewers = Interviewer.all
    end

    private

    def interviewer_params
        params.require(:interviewer).permit(:name, :email, :password, :uid, :image, :job_title, :job_level, :experience, :is_manager, :is_active, :rate)
    end

    def generate_random_id
        self.id = SecureRandom.uuid
    end 
    
end
