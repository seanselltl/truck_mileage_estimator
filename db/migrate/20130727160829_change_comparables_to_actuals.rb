class ChangeComparablesToActuals < ActiveRecord::Migration
  def change
    rename_table :comparables, :actuals
  end
end
