class AddAuthorToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :author_id, :integer
  end
end
