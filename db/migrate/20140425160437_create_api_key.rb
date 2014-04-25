# Creates the api_keys table with name and access_token columns
class CreateApiKey < ActiveRecord::Migration
    def change
        create_table :api_keys do |table|
            table.string :name
            table.string :access_token
            table.belongs_to :user

            table.timestamps
        end
    end
end
