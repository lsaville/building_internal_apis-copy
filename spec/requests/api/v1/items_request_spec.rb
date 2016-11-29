require 'rails_helper'

describe 'items endpoints' do
  context 'GET /items' do
    it 'returns a list of all items' do
      create_list(:item, 3)
      get '/api/v1/items'

      items = JSON.parse(response.body)
      expect(response).to be_success
      expect(items.count).to eq(3)
    end
  end

  context 'GET /item/:id' do
    it 'returns an item' do
      item = create(:item)

      get "/api/v1/items/#{item.id}"

      returned_item = JSON.parse(response.body)

      expect(response).to be_success
      expect(item.id).to eq(returned_item["id"])
    end
  end

  context 'POST /items' do
    it 'creates a new item' do
      expect{
        post '/api/v1/items', {name: 'Turducken', price: 1111111}
      }.to change{Item.count}.by(1)

      expect(response).to be_success
    end
  end
end
