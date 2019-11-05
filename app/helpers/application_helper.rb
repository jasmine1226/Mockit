module ApplicationHelper
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

    def account_type
        session[:account_type]
    end
end
