class CreateTeams < ActiveRecord::Migration[6.0]
  def change
    create_table :teams, id: false, force: true do |t|
      t.string :id, :limit => 36, :primary_key => true
      t.string :name
      t.string :lead_id
      t.boolean :active

      t.timestamps
    end
  end
end
