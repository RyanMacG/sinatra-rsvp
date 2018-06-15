class Rsvp < Sequel::Model
  def extra_guests?
    guests.positive?
  end
end
