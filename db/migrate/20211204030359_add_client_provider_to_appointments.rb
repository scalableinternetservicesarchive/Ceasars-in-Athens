class AddClientProviderToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :service_title, :string
    add_column :appointments, :user_name, :string
    add_column :appointments, :provider_id, :integer
    add_column :appointments, :provider_name, :string
  end
end
