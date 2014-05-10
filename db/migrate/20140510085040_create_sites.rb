class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :title
      t.string :url
      t.string :user_id

      t.timestamps
    end
  end
end
