class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :trip, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :address
      t.string :status
      t.integer :price
      t.string :url


      t.timestamps
    end
  end
end
