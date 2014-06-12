class CreateUrlshortners < ActiveRecord::Migration
  def change
    create_table :urlshortners do |t|
      t.string :url
      t.string :tinyurl

      t.timestamps
    end
  end
end
