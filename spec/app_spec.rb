RSpec.describe App do
  let(:db) { DB }

  after do
    db[:rsvps].truncate
  end

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
    before do
      db[:rsvps].insert(name: 'Foo Bar', access_key: 'abc123')
      db[:rsvps].insert(name: 'Baz Qux and Bar Qux', dietary: 'Gluten free', access_key: 'xyz456')
    end

    context 'visiting /api/rsvps' do
      before { get '/api/rsvps' }

      let(:rsvp_json) {
        [
          {
            name: 'Foo Bar',
            dietary: ''
          },
          {
            name: 'Baz Qux and Bar Qux',
            dietary: 'Gluten free'
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

      context 'invalid access key' do
        context 'visiting /api/rsvps/not-a-key' do
          before { get '/api/rsvps/not-a-key' }
          let(:error) {
            {
              message: 'the rsvp was not found'
            }.to_json
          }

          it 'returns a 404' do
            expect(last_response.status).to eq(404)
          end

          it 'responds with the RSVP' do
            expect(last_response.body).to eq(error)
          end
        end
      end
    end
  end
end
