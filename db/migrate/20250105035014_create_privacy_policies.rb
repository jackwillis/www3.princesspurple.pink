class CreatePrivacyPolicies < ActiveRecord::Migration[8.0]
  def change
    create_table :privacy_policies do |t|
      t.string :version, null: false
      t.date :effective_date, null: false
      t.text :content, null: false

      t.timestamps
    end

    add_index :privacy_policies, :effective_date
  end
end
