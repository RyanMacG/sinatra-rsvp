RSpec.describe App do
  context 'visiting /api/health' do
    before { get '/api/health' }

    it 'returns a 200' do
      expect(last_response).to be_ok
    end

    it 'returns "Hello" in the body' do
      expect(last_response.body).to include('Application is running')
    end
  end

  describe 'RSVP routes' do
    context 'visiting /api/rsvps' do
      before { get '/api/rsvps' }

      let(:rsvp_json) {
        [
          {
            name: 'Foo Bar',
            dietary: '',
            access_key: 'abc123'
          },
          {
            name: 'Baz Qux and Bar Qux',
            dietary: 'Gluten free',
            access_key: 'xyz456'
          }
        ].to_json
      }

      it 'returns a 200' do
        expect(last_response).to be_ok
      end

      it 'returns a list of RSVPs' do
        expect(last_response.body).to eq(rsvp_json)
      end
    end

    describe 'access keys' do
      context 'visiting /api/rsvps/abc123' do
        before { get '/api/rsvps/abc123' }

        let(:rsvp) {
          {
            name: 'Foo Bar',
            dietary: '',
            access_key: 'abc123'
          }.to_json
        }

        it 'returns a 200' do
          expect(last_response).to be_ok
        end

        it 'responds with the corresponding RSVP' do
          expect(last_response.body).to eq(rsvp)
        end
      end

      context 'visiting /api/rsvps/xyz456' do
        before { get '/api/rsvps/xyz456' }
        let(:rsvp) {
          {
            name: 'Baz Qux and Bar Qux',
            dietary: 'Gluten free',
            access_key: 'xyz456'
          }.to_json
        }

        it 'returns a 200' do
          expect(last_response).to be_ok
        end

        it 'responds with the RSVP' do
          expect(last_response.body).to eq(rsvp) 
        end
      end
    end
  end
end
