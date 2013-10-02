class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :instituition
      t.string :qualification
      t.string :type
      t.datetime :graduated_at

      t.timestamps
    end
  end
end
