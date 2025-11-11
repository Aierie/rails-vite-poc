class CreateContractors < ActiveRecord::Migration[7.2]
  def change
    create_table :contractors do |t|
      t.string :name
      t.string :specialty
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
