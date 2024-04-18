class CreateGuestComments < ActiveRecord::Migration[7.1]
  def change
    create_table :guest_comments do |t|
      t.references :post, null: false, foreign_key: true
      
      t.text :body
      t.timestamps
    end
  end
end
