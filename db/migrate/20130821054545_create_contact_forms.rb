class CreateContactForms < ActiveRecord::Migration
  def change
    create_table :contact_forms do |t|
      t.string :full_name
      t.string :email
      t.string :about
      t.string :message

      t.timestamps
    end
  end
end
