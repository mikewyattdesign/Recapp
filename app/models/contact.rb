class Contact < ActiveRecord::Base
    has_and_belongs_to_many :events

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :state, length: { is: 2 }, allow_blank: true
    validates :email, format: { with: /@/, message: "Please use valid email" }, allow_blank: true
    validates :mobile_phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "Please use the 'xxx-xxx-xxxx' format" }, allow_blank: true
    validates :desk_phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "Please use the 'xxx-xxx-xxxx' format" }, allow_blank: true

    def full_name
        "#{first_name} #{last_name}"
    end

    def city_state_zip
        "#{city}, #{state} #{zip}"
    end

    def m_phone
        "<span class='brand-primary'>M:</span> #{mobile_phone}".html_safe unless mobile_phone.empty?
    end

    def d_phone
        "<span class='brand-primary'>D:</span> #{desk_phone}".html_safe unless desk_phone.empty?
    end
end