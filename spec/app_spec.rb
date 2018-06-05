RSpec.describe App do
  describe 'visiting /api/health' do
    before { get '/api/health' }

    it 'returns a 200' do
      expect(last_response).to be_ok
    end

    it 'returns "Hello" in the body' do
      expect(last_response.body).to include('Application is running')
    end
  end
end
