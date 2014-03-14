class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug, index: true
      t.text :copy
      t.date :pub_date, index: true

      t.timestamps
    end
  end
end
