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
        if account_type == "interviewer"
            if @interviewer = Interviewer.find_by(uid: auth['uid'])                
                session[:id] = @interviewer.id
                session[:account_type] = 'Interviewer'
                redirect_to root_path
            else
                session[:auth] = {
                    uid: auth['uid'],
                    name: auth['info']['name'],
                    email: auth['info']['email'],
                    image: auth['info']['image']
                }
                redirect_to new_interviewer_path
            end
        elsif account_type == "interviewee"
            if @interviewee = Interviewee.find_by(uid: auth['uid'])
                session[:id] = @interviewee.id
                session[:account_type] = 'Interviewee'
                redirect_to root_path
            else 
                session[:auth] = {
                    uid: auth['uid'],
                    name: auth['info']['name'],
                    email: auth['info']['email'],
                    image: auth['info']['image']
                }
                redirect_to new_interviewee_path
            end
        else
            redirect_to root_path
        end
    end

    def index
        if session[:id]
            redirect_to root_path
        end
    end

    def destroy
        session.delete :id
        session.delete :account_type
        session.delete :auth
        redirect_to root_path
    end

    private

    def auth
        request.env['omniauth.auth']
    end

    def account_type
        request.env['omniauth.params']['account_type'] 
    end

end