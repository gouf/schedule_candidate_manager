class AddRefreshTokenColumnToTokens < ActiveRecord::Migration[6.0]
  def change
    add_column :tokens, :refresh_token, :string
  end
end
