require 'rails_helper'

RSpec.describe 'Api::V1::Notes', type: :request do
  describe 'GET /api/v1/notes' do
    it 'retorna a lista de anotações ordenadas por data' do
      Note.delete_all

      create(:note, title: 'Antiga', created_at: 2.days.ago)
      create(:note, title: 'Nova', created_at: 1.day.ago)

      get '/api/v1/notes'

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json.first['title']).to eq('Nova')
      expect(json.last['title']).to eq('Antiga')
    end
  end

  describe 'POST /api/v1/notes' do
    context 'com dados válidos' do
      it 'cria uma anotação' do
        params = {
          note: attributes_for(:note)
        }

        expect {
          post '/api/v1/notes', params: params
        }.to change(Note, :count).by(1)

        expect(response).to have_http_status(:created)

        json = JSON.parse(response.body)

        expect(json['title']).to eq(params[:note][:title])
        expect(json).to have_key('id')
      end
    end

    context 'com dados inválidos' do
      it 'não cria anotação sem título' do
        post '/api/v1/notes', params: { note: { title: nil } }

        expect(response).to have_http_status(:unprocessable_entity)

        json = JSON.parse(response.body)

        expect(json['errors']).to be_an(Array)
        expect(json['errors']).not_to be_empty
        expect(json['errors'].first).to be_a(String)
      end
    end
  end
end
