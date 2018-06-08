Sequel.migration do
  up do
    create_table(:rsvps) do
      primary_key :id
      String :name, null: false
      String :dietary, default: ''
      String :access_key, null: false
    end

    add_index :rsvps, :access_key, unique: true
  end

  down do
    drop_table(:rsvps)
  end
end
