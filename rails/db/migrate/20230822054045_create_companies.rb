class CreateCompanies < ActiveRecord::Migration[7.0]
  ## done
  def change
    create_table :companies do |t|
      t.string :name, null:false
      t.bigint :ieul_company_id, null:false

      t.timestamps
    end
  end
end
