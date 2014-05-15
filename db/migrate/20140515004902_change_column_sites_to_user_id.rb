class ChangeColumnSitesToUserId < ActiveRecord::Migration
  def change
    change_column :sites, :user_id, :integer
  end
end
