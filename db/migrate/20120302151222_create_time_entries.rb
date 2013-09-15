class CreateTimeEntries < ActiveRecord::Migration
	def change
		create_table :time_entries do |t|
			t.float :hours_spent
			t.date  :spent_on
			t.references :user
			t.references :trackable, :polymorphic => true
			t.timestamps
		end
	end
end