RSpec.describe Rsvp do
  let(:db) { DB }

  after do
    db[:rsvps].truncate
  end

  context 'extra_guests?' do
    before do
      db[:rsvps].insert(name: 'Foo Bar', access_key: 'abc123')
      db[:rsvps].insert(name: 'Baz Qux and Bar Qux', dietary: 'Gluten free', access_key: 'xyz456')
    end

    context 'without any extra guests' do
      let(:rsvp) { Rsvp.first }

      it 'returns false' do
        expect(rsvp.extra_guests?).to eq(false)
      end
    end

    context 'with extra guests' do
      before { db[:rsvps].insert(name: 'Foo Bar', access_key: 'snakes', guests: 1) }
      let(:rsvp) { Rsvp.last }

      it 'returns true' do
        expect(rsvp.extra_guests?).to eq(true)
      end
    end
  end
end
