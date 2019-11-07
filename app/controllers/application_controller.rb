class ApplicationController < ActionController::Base
    def logged_in?
        session[:id]
    end

    def current_user?
        if params[:account_type] == 'Interviewer'
            if params[:id] == session[:id]
                @interviewer = Interviewer.find(session[:id])
            end
        elsif params[:account_type] == 'Interviewee'
            if params[:id] == session[:id]
                @interviewee = Interviewee.find(session[:id])
            end
        end
    end
end
