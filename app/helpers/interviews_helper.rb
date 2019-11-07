module InterviewsHelper
    
    def datetime(interview)
        datetime = interview.date + interview.time.seconds_since_midnight.seconds
    end

    def display_date(interview)        
        interview.date.strftime("%A, %b %e %Y")
    end

    def display_time(interview)
        interview.time.strftime("%l:%M %p")
    end
end
