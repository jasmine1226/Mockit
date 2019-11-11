class SessionsController < ApplicationController

    def new
    end

    def create
        if params[:account_type] == 'Interviewer'
            @interviewer = Interviewer.find_by(email: params[:email])
            if @interviewer && @interviewer.authenticate(params[:password])
                session[:id] = @interviewer.id
                session[:account_type] = params[:account_type] 
                redirect_to interviewer_path(@interviewer)
            else
                @error = "Either the email or password is incorrect."
                render :new
            end

        elsif params[:account_type] == 'Interviewee'
            @interviewee = Interviewee.find_by(email: params[:email])
            if @interviewee && @interviewee.authenticate(params[:password])
                session[:id] = @interviewee.id 
                session[:account_type] = params[:account_type]           
                redirect_to interviewee_path(@interviewee)
            else                
                @error = "Either the email or password is incorrect."
                render :new
            end
        else
            @error = "Please select your account type."
            render :new
        end
    end

    def create_from_fb
        if request.env['omniauth.params']['account_type'] == "interviewer"
            if @interviewer = Interviewer.find_by(uid: auth['uid'])                
                session[:id] = @interviewer.id
                session[:account_type] = 'Interviewer'
                redirect_to '/'
            else 
                @interviewer = Interviewer.new do |i|
                    i.name = auth['info']['name']
                    i.email = auth['info']['email']
                    i.image = auth['info']['image']
                    i.uid = auth['uid']
                    i.password_digest = SecureRandom.urlsafe_base64 
                end
                @interviewer.save      
                session[:id] = @interviewer.id
                session[:account_type] = 'Interviewer'
                redirect_to edit_interviewer_path(@interviewer)
            end
        elsif request.env['omniauth.params']['account_type'] == "interviewee"
            if @interviewee = Interviewee.find_by(uid: auth['uid'])
                session[:id] = @interviewee.id
                session[:account_type] = 'Interviewee'
                render :new
            else 
                @interviewee = Interviewee.new do |i|
                    i.name = auth['info']['name']
                    i.email = auth['info']['email']
                    i.image = auth['info']['image']
                    i.uid = auth['uid']
                    i.password_digest = SecureRandom.urlsafe_base64 
                end
                @interviewee.save      
                session[:id] = @interviewee.id
                session[:account_type] = 'Interviewee'
                redirect_to edit_interviewee_path(@interviewee)
            end
        else

        end
    end

    def destroy
        session.delete :id
        session.delete :account_type
        redirect_to '/'
    end

    private

    def auth
        request.env['omniauth.auth']
    end
end