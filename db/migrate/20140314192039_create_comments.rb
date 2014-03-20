class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :post, index: true

      t.timestamps
    end
  end
end
