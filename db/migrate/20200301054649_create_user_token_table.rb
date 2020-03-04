class CreateUserTokenTable < ActiveRecord::Migration[6.0]
  def change
    create_table :tokens do |t|
      t.column :user_id, :integer
      t.column :token, :string
      t.column :expires_at, :datetime
    end
  end
end
