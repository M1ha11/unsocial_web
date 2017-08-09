require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  login_user
  describe "GET #search" do

    let(:request_exec) { get :search, params: { query: query, autocomplete: true }, format: :json }
    let(:output_hash) { { test: 'test' } }
    let(:elasticsearch) { class_double("Elasticsearch::Model").as_stubbed_const }
    before(:example) { allow(elasticsearch).to receive_message_chain(:search, :records, :to_a) { output_hash } }

    context 'query exist' do
      let(:query) { 'query' }
      it "uses ElasticSearch to assigns the @results" do
        request_exec
        expect(assigns(:results)).to eq(output_hash)
      end

      it "renders @results collection in JSON format" do
        request_exec
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq(output_hash.to_json)
      end
    end

    context 'query nil' do
      let(:query) { nil }
      it "uses ElasticSearch to assigns the @results" do
        request_exec
        expect(assigns(:results)).to eq([])
      end
    end
  end

  describe "GET #tag_search" do

    let(:request_exec) { get :tag_search, params: { q: q, autocomplete: true }, format: :json }
    let(:output_hash) { { content: 'tags' } }
    let(:elasticsearch) { class_double("Tag").as_stubbed_const }
    before(:example) { allow(elasticsearch).to receive_message_chain(:search, :records, :all, :first) { output_hash } }

    context 'query exist' do
      let(:q) { 'tags' }
      it "uses ElasticSearch to assigns the @tags" do
        request_exec
        expect(assigns(:tags)).to eq(output_hash)
      end

      it "renders @tags collection in JSON format" do
        request_exec
        expect(response.content_type).to eq('application/json')
        expect(response.body).to eq(output_hash.to_json)
      end
    end

    context 'query nil' do
      let(:q) { nil }
      it "uses ElasticSearch to assigns the @tags" do
        request_exec
        expect(assigns(:tags)).to eq([])
      end
    end
  end
end

