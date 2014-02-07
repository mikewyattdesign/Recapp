class Program < ActiveRecord::Base
    has_many :events
    belongs_to :brand

    def program_plus_brand
        "#{self.name} (#{self.brand.name})"
    end
end
