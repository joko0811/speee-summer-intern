class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.references :company, null: false, foreign_key: true
      t.references :city, null: false, foreign_key: true
      t.references :assessment_area, foreign_key: true
      t.references :original_review, foreign_key: true
      t.references :latest_review, foreign_key: true
      t.string :name
      t.string :logo_url, null: false
      t.string :post_code
      t.string :address,null:false
      t.string :phone_number
      t.string :fax_number
      t.string :open_time
      t.string :holiday
      t.string :catch_copy, null:false
      t.string :introduction, null:false

      t.timestamps
    end
  end
end
