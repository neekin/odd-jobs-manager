class CreateGigUserTags < ActiveRecord::Migration[8.1]
  def change
    create_table :gig_user_tags do |t|
      t.references :gig_user, null: false, foreign_key: { to_table: :gig_users }
      t.references :tag, null: false, foreign_key: true
      t.timestamps
    end

    add_index :gig_user_tags, [ :gig_user_id, :tag_id ], unique: true
  end
end
