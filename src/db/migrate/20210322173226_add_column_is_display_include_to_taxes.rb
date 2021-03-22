class AddColumnIsDisplayIncludeToTaxes < ActiveRecord::Migration[5.2]
  def change
    add_column :taxes, :is_display_include, :boolean, default: true
  end
end
