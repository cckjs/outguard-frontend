class CreateFilterWords < ActiveRecord::Migration
  def change
    create_table :filter_words do |t|

      t.string :word

      t.timestamps null: false
    end
  end
end
