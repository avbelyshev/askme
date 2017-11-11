class AddHeaderBackgroundToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :header_background, :string
  end
end
