class CreateAuthorizeCodes < ActiveRecord::Migration
  def change
    create_table :authorize_codes do |t|
      t.text :code

      t.timestamps null: false
    end
  end
end
