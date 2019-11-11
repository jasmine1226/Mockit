class IntervieweesController < ApplicationController
    before_action :set_interviewee, only: [:show, :edit, :update, :destroy]
    before_action :require_login, except: [:new, :create, :show, :index]
    
    def new
        @interviewee = Interviewee.new
    end

    def create
        @interviewee = Interviewee.new(interviewee_params)
        if @interviewee.save            
            session[:id] = @interviewee.id
            session[:account_type] = 'Interviewee'
            redirect_to interviewee_path(@interviewee)
        else
            render :new
        end
    end

    def show        
        if !@interviewee
            redirect_to interviewees_path, alert: "Interviewee not found."
        end
    end

    def edit
    end

    def update
        @interviewee.update(interviewee_params)
        if @interviewee.save
            redirect_to interviewee_path(@interviewee)
        else
            render :edit
        end
    end

    def destroy
        @interviewee.destroy
        session.delete :id
        session.delete :account_type
        redirect_to '/'
    end
    
    def index
        @interviewees = Interviewee.all
    end

    private

    def interviewee_params
        params.require(:interviewee).permit(:name, :email, :password, :uid, :image, :job_title, :job_level, :experience, :balance)
    end

    def set_interviewee
        @interviewee = Interviewee.find_by_id(params[:id])
    end
end
