class CreateEmailValidators < ActiveRecord::Migration[6.1]
  def change
    create_table :email_validators do |t|
      t.string      :first_name,     null: false
      t.string      :last_name,      null: false
      t.string      :email,          null: false
      t.string      :url,            null: false
      t.timestamps
    end
  end
end
