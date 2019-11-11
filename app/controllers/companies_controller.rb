class CompaniesController < ApplicationController

    def show
        @company = Company.find_by_id(params[:id])
        @interviewers = @company.interviewers.active
    end
end