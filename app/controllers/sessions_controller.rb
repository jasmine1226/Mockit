class SessionsController < ApplicationController

    def new
    end

    def create
        if auth
            @interviewer = Interviewer.find_or_create_by(uid: auth['uid']) do |i|
                i.name = auth['info']['name']
                i.email = auth['info']['email']
                i.image = auth['info']['image']
                i.id = SecureRandom.uuid
            end
           
            session[:id] = @interviewer.id
            redirect_to interviewer_path(@interviewer)

        elsif params[:account_type] == 'Interviewer'
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

    private

    def auth
        request.env['omniauth.auth']
    end
end