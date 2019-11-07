class ApplicationController < ActionController::Base
    private
    
    def require_login
        return head(:forbidden) unless session.include? :id
    end
end
