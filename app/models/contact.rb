class Contact < ActiveRecord::Base
    has_and_belongs_to_many :events

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :state, length: { is: 2 }, allow_blank: true
    validates :email, format: { with: /@/, message: "Please use valid email" }, allow_blank: true
    validates :mobile_phone, format: { with: /\d{3} \d{3} \d{4}/, message: "Please use the 'xxx xxx xxxx' format" }, allow_blank: true
    validates :desk_phone, format: { with: /\d{3} \d{3} \d{4}/, message: "Please use the 'xxx xxx xxxx' format" }, allow_blank: true
end