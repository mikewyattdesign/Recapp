class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
        t.string :first_name
        t.string :last_name
        t.string :title
        t.string :address
        t.string :city
        t.string :state
        t.string :zip
        t.string :email
        t.string :mobile_phone
        t.string :desk_phone

        t.timestamps
    end
  end
end
