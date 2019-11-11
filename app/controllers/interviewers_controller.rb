class InterviewersController < ApplicationController
    before_action :set_interviewer, only: [:show, :edit, :update, :destroy]    
    before_action :require_login, except: [:new, :create, :show, :index]
    
    def new
        @interviewer = Interviewer.new
    end

    def create
        @interviewer = Interviewer.new(interviewer_params)
        if @interviewer.save
            session[:id] = @interviewer.id
            session[:account_type] = 'Interviewer'
            redirect_to interviewer_path(@interviewer)
        else
            render :new
        end
    end

    def show
        if !@interviewer
            redirect_to interviewers_path
        end        
    end

    def edit
    end

    def update
        @interviewer.update(interviewer_params)
        if @interviewer.save
            redirect_to interviewer_path(@interviewer)
        else
            render :edit
        end
    end

    def destroy
        @interviewer.destroy
        session.delete :id
        session.delete :account_type
        redirect_to '/'
    end

    def index
        @interviewers = Interviewer.all
    end
  

    private    

    def interviewer_params
        params.require(:interviewer).permit(:name, :email, :password, :uid, :image, :job_title, :job_level, :experience, :is_manager, :is_active, :rate)
    end

    def set_interviewer
        @interviewer = Interviewer.find_by_id(params[:id])
    end

end
