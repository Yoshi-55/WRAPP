class AddCustomerFieldsToJobs < ActiveRecord::Migration[7.1]
  def change
    add_column :jobs, :car_year, :integer
    add_column :jobs, :car_color, :string
    add_column :jobs, :customer_name, :string
    add_column :jobs, :customer_phone, :string
    add_column :jobs, :scheduled_at, :datetime
    add_column :jobs, :note, :text
  end
end
