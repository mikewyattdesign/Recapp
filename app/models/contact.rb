class Contact < ActiveRecord::Base
    has_and_belongs_to_many :events

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email, format: { with: /@/, message: "Please use valid email" }
    validates :mobile_phone, format: { with: /\d{3} \d{3} \d{4}/, message: "Please use the 'xxx xxx xxxx' format" }
    validates :desk_phone, format: { with: /\d{3} \d{3} \d{4}/, message: "Please use the 'xxx xxx xxxx' format" }
end