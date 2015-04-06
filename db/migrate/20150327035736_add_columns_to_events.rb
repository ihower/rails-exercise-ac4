class AddColumnsToEvents < ActiveRecord::Migration

  def change
    add_column :events, :published_at, :datetime
    add_column :events, :due_date, :date
  end

end
