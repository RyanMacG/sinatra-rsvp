Sequel.migration do
  up do
    add_column :rsvps, :guests, Integer, default: 0
  end

  down do
    remove_column :rsvps, :guests
  end
end
