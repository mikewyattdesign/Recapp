module ProgramHelper
    def photo_grid_class(photos)
        if grid_size(photos) > 1
            "col-xs-#{grid_size(photos)}"
        else
            'col-xs-1'
        end
    end

    def grid_size(elements)
        12 / elements.count
    end
end
