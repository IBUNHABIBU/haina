module ActivitiesHelper
    def status_badge_color(status)
        case status.to_s
        when "received"
        "bg-yellow-100 text-yellow-800"
        when "completed"
        "bg-green-100 text-green-800"
        when "returned"
        "bg-blue-100 text-blue-800"
        when "irepairable"
        "bg-red-100 text-red-800"
        else
        "bg-gray-100 text-gray-800"
        end
    end
end
