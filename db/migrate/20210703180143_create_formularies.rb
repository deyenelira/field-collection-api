class CreateFormularies < ActiveRecord::Migration[5.2]
  def change
    create_table :formularies do |t|
      t.string :name

      t.timestamps
    end
  end
end
