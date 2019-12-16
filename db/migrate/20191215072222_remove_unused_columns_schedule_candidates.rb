class RemoveUnusedColumnsScheduleCandidates < ActiveRecord::Migration[6.0]
  def change
    remove_columns(:schedule_candidates, :corporation_name, :description, :location)
  end
end
