Sequel.migration do
  up do
    add_column :rsvps, :guest_details, 'json'
  end

  down do
    remove_column :rsvps, :guest_details
  end
end
