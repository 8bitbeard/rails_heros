require 'rails_helper'

# rubocop:disable Metris/BlockLength
RSpec.describe 'api/v1/heroes', type: :request do

  let(:valid_attributes) { attributes_for :hero }

  let(:invalid_attributes) { attributes_for :invalid_hero }

  let(:valid_headers) do
    { Authorization: valid_attributes[:token] }
  end

  let(:invalid_headers) do
    { Authorization: invalid_attributes[:token] }
  end

  describe 'GET /index' do
    context 'with headers' do
      it 'renders a successful response' do
        hero = Hero.create! valid_attributes
        get api_v1_heroes_url, headers: valid_headers, as: :json
        expect(response).to be_successful
        expect(json_response.first[:name]).to eq hero.name
      end
    end

    context 'without headers' do
      it 'renders a JSON response with an unauthorized status' do
        Hero.create! valid_attributes
        get api_v1_heroes_url, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with invalid headers' do
      it 'renders a JSON response with an unauthorized status' do
        Hero.create! valid_attributes
        get api_v1_heroes_url, headers: invalid_headers, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'GET /show' do
    context 'with headers' do
      it 'renders a sucessful resonse' do
        hero = Hero.create! valid_attributes
        get api_v1_hero_url(hero), headers: valid_headers, as: :json
        expect(response).to be_successful
      end
    end

    context 'without headers' do
      it 'renders a JSON resonse with an unauthorized status' do
        hero = Hero.create! valid_attributes
        get api_v1_hero_url(hero), as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Hero' do
        expect do
          post api_v1_heroes_url, params: { hero: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Hero, :count).by(1)
      end

      it 'renders a JSON response with the new Hero' do
        post api_v1_heroes_url,
          params: { hero: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it'does not create a new Hero' do
        expect do
          post api_v1_heroes_url,
            params: { hero: invalid_attributes }, headers: valid_headers, as: :json
        end.to change(Hero, :count).by(0)
      end

      it 'renders a JSON response with errors for the new Hero' do
        post api_v1_heroes_url,
          params: { hero: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PUT /update' do
    context 'with valid parameters' do

      let(:new_attributes) { attributes_for :hero }

      it 'updates the requested hero' do
        hero = Hero.create! valid_attributes
        put api_v1_hero_url(hero),
          params: { hero: new_attributes }, headers: valid_headers, as: :json
        hero.reload
        expect(hero.name).to eq(new_attributes[:name])
      end

      it 'renders a JSON response wuth the hero' do
        hero = Hero.create! valid_attributes
        put api_v1_hero_url(hero),
          params: { hero: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match (a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the Hero' do
        hero = Hero.create! valid_attributes
        put api_v1_hero_url(hero),
          params: { hero: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested hero' do
      hero = Hero.create! valid_attributes
      expect do
        delete api_v1_hero_url(hero), headers:  valid_headers, as: :json
      end.to change(Hero, :count).by(-1)
    end
  end
end
