class SessionsController < ApplicationController

    def new
    end

    def create
        if params[:account_type] == 'Interviewer'
            @interviewer = Interviewer.find_by(email: params[:email])
            if @interviewer.authenticate(params[:password])
                 session[:id] = @interviewer.id
                 redirect_to interviewer_path(@interviewer)
            else 
                redirect_to '/login'
            end
        elsif params[:account_type] == 'Interviewee'
            @interviewee = Interviewee.find_by(email: params[:email])
            if @interviewee.authenticate(params[:password])
                 session[:id] = @interviewee.id                 
                 redirect_to interviewee_path(@interviewee)
            else 
                redirect_to '/login'
            end
        end
    end

    def destroy
        session.delete :id
        redirect_to '/'
    end
end