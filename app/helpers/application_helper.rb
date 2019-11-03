module ApplicationHelper
    def current_user
        if session[:id]
            if Interviewer.find_by_id(session[:id])
                @current_user = Interviewer.find(session[:id])
            else
                @current_user = Interviewee.find(session[:id])
            end
        else
            @current_user = nil
        end
    end
end
