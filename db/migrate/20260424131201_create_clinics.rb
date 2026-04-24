class CreateClinics < ActiveRecord::Migration[8.1]
  def change
    create_table :clinics do |t|
      t.string :name
      t.string :cnpj
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
