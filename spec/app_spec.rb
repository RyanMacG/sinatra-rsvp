RSpec.describe App do
  describe 'visiting /' do
    before { get '/' }

    it 'returns a 200' do
      expect(last_response).to be_ok
    end

    it 'returns "Hello" in the body' do
      expect(last_response.body).to include('Hello')
    end
  end
end
