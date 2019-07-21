class CreateImages < ActiveRecord::Migration[6.0]
  def change
    create_table :images do |t|
      t.string :size
      t.string :url
      t.references :album
    end
  end
end
