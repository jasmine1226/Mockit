class CompaniesController < ApplicationController

    def show
        if @company = Company.find_by_id(params[:id])          
            @interviewers = @company.interviewers.active
        else
            redirect_to companies_path, alert: "Company not found."
        end   
    end

    def index
        @companies = Company.all.order(name: :asc)
    end
end