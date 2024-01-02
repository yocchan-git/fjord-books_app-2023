class AddPostCodeAddressSelfIntroductionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :post_code, :string
    add_column :users, :address, :string
    add_column :users, :self_introduction, :text
  end
end
