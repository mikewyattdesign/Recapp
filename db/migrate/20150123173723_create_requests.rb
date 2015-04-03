class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.references :requestor, index: true
      t.references :requestable, polymorphic: true, index: true
      t.integer :request_type
      t.boolean :complete, default: false
      t.timestamps
    end
  end
end
