class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships, id: false, force: true do |t|
      t.string :id, :limit => 36, :primary_key => true
      t.string :google_user_id
      t.references :team, foreign_key: true, type: :string
      t.boolean :active

      t.timestamps
    end
  end
end
