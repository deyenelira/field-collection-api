class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.date :date
      t.string :status
      t.datetime :checkin_at
      t.datetime :checkout_at
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
