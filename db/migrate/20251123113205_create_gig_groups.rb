class CreateGigGroups < ActiveRecord::Migration[8.1]
  def change
    create_table :gig_groups do |t|
      t.string :name, null: false
      t.string :remark
      t.timestamps
    end
  end
end
