class Program < ActiveRecord::Base
    has_many :events
    belongs_to :brand

    validates :name, presence: true
    validates :brand_id, presence: true

    def program_plus_brand
        "#{self.name} (#{self.brand.name})"
    end
end
