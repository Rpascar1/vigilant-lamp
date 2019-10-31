class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
        t.string :name
        t.string :body
        t.string :status
        t.integer :user_id
    end
  end
end
