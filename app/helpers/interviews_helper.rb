module InterviewsHelper
    
    def display_time(interview)
        datetime = interview.date + Time.parse("16:30").seconds_since_midnight.seconds
        interview.date.strftime("%A, %b %e, at %l:%M %p")
    end
end
