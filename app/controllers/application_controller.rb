class ApplicationController < ActionController::Base
    private
    
    def require_login
        return head(:forbidden) unless session.include? :id
    end

    def current_user
        if session[:id]
            if session[:account_type] == "Interviewer"
                @current_user = Interviewer.find(session[:id])
            elsif session[:account_type] == "Interviewee"
                @current_user = Interviewee.find(session[:id])
            end
        else
            @current_user = nil
        end
    end

    def is_current_user(account_type)
        session[:id] == params[:id] && session[:account_type] == account_type
    end
end
