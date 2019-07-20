class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.string :title
      t.references :artist
      t.references :album
      # is it necessary?
      t.string :image
    end
  end
end
