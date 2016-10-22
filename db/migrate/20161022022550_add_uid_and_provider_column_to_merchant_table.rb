class AddUidAndProviderColumnToMerchantTable < ActiveRecord::Migration
  def change
    add_column :merchants, :uid, :integer, limit: 9 #null: false # this is the identifier provided by Github
    add_column :merchants, :provider, :string #null: false # this tells us who provided the identifier
  end
end
