class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :content
      t.references :formulary, foreign_key: true
      t.references :question, foreign_key: true
      t.references :visit, foreign_key: true
      t.datetime :answered_at

      t.timestamps
    end
  end
end
