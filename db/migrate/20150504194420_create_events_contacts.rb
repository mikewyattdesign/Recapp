class CreateEventsContacts < ActiveRecord::Migration
  def change
    create_table :events_contacts do |t|
        t.integer :event_id
        t.integer :contact_id
    end
  end
end
