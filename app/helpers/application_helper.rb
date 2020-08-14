module ApplicationHelper

    def flash_style(level)
        case level
            when 'notice' then "alert alert-success"
            when 'error' then "alert alert-danger"
            when 'alert' then "alert alert-warning"
        end
    end

end
