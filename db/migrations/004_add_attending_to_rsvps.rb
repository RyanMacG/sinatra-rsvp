Sequel.migration do
  up do
    add_column :rsvps, :attending, :boolean, default: false, nil: false
  end

  down do
    remove_column :rsvps, :attending
  end
end
