class CreateMyPages < ActiveRecord::Migration
  def change
    create_table :my_pages do |t|
      t.integer :page_id

      t.timestamps null: false
    end
  end
end
