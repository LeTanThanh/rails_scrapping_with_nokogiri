class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :image
      t.string :country
      t.string :category
      t.string :producer
      t.string :actors
      t.datetime :publish_day

      t.timestamps
    end
  end
end
