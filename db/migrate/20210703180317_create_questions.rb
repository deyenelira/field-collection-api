class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.string :name
      t.references :formulary, foreign_key: true
      t.string :question_type

      t.timestamps
    end
  end
end
