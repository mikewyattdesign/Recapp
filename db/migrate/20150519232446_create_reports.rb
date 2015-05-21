class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :reportable, polymorphic: true, index: true
      t.attachment :report
      t.timestamps
    end
  end
end
