class InterviewersController < ApplicationController
    before_action :set_interviewer, only: [:show, :edit, :update, :destroy]    
    before_action :require_login, except: [:new, :create, :show, :index]
    
    def new
        @interviewer = Interviewer.new
        @interviewer.build_company
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
            redirect_to interviewers_path, alert: "Interviewer not found."
        end        
    end

    def edit
        if !is_current_user("Interviewer")
            redirect_to interviewers_path, alert: "Access not authorized."
        end
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
        @interviewers = Interviewer.active.filter_by(filtering_params).order(name: :asc)
    end
  

    private    

    def interviewer_params
        params.require(:interviewer).permit(:name, :email, :password, :uid, :image, :job_title, :job_level, :experience, :is_manager, :is_active, :rate, company_attributes: [:name])
    end

    def filtering_params
        params.permit(:company, :job_title, :job_level, :experience, :is_manager, :company_id)
    end

    def set_interviewer
        @interviewer = Interviewer.find_by_id(params[:id])
    end

end
