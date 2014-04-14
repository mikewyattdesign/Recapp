class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.references :documentable, index: true

      t.timestamps
    end
  end
end
