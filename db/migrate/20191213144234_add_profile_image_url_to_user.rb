class AddProfileImageUrlToUser < ActiveRecord::Migration[6.0]
  def change
    add_column(:users, :profile_image_url, :string, default: '')
  end
end
