# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :request do
  let(:base_url) { '/users' }
  let(:user) { create(:user) }
  let(:updated_params) { build(:user_params) }
  let(:invalid_updated_params) { build(:user_invalid_params) }
  let(:expected_index_attributes) { %w[id name] }
  let(:expected_create_attributes) { expected_index_attributes.push('email', 'age', 'dataset', 'created_at', 'updated_at') }
  let(:expected_show_attributes) { expected_create_attributes.push('capt_description') }

  describe 'GET #index' do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    it 'responds with 200 status' do
      get base_url

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).map{|x| x['id']}).to eq([user1.id, user2.id])
      expect(JSON.parse(response.body).map{|x| x['name']}).to eq([user1.name, user2.name])
      expect(JSON.parse(response.body).sample.keys).to match_array(expected_index_attributes)
    end
  end

  describe 'GET #show' do
    it 'responds with 200 status' do
      get "#{base_url}/#{user.id}"

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['id']).to eq(user.id)
      expect(JSON.parse(response.body)['name']).to eq(user.name)
      expect(JSON.parse(response.body).keys).to match_array(expected_show_attributes)
    end
  end

  describe 'POST #create' do
    it 'responds with 201 status' do
      post base_url, params: { user: updated_params }

      expect(response.status).to eq(201)
      expect(JSON.parse(response.body)['name']).to eq(updated_params[:name])
      expect(JSON.parse(response.body).keys).to match_array(expected_create_attributes)
    end

    it 'responds with 422 status' do
      post base_url, params: { user: invalid_updated_params }

      expect(response.status).to eq(422)
    end
  end

  describe 'PATCH #update' do
    it 'responds with 201 status' do

      patch "#{base_url}/#{user.id}", params: { user: updated_params }

      expect(response.status).to eq(200)
      expect(JSON.parse(response.body)['name']).to eq(updated_params[:name])
      expect(JSON.parse(response.body).keys).to match_array(expected_create_attributes)
    end

    it 'responds with 422 status' do

      patch "#{base_url}/#{user.id}", params: { user: invalid_updated_params }

      expect(response.status).to eq(422)
    end
  end

  describe '#destroy' do
    it 'record was deleted' do
      delete "#{base_url}/#{user.id}"
      expect(response).to have_http_status(:no_content)
    end
  end
end
