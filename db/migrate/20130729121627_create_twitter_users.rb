class CreateTwitterUsers < ActiveRecord::Migration
  def change
    create_table :twitter_users do |t|
      t.string :username
      t.string :user_id
      t.string :name
      t.string :location
    end
  end
end
