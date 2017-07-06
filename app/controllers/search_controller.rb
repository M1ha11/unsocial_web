class SearchController < ApplicationController
  def search
    if params[:query].nil?
      @results = []
    else
      @results = Elasticsearch::Model.search((params[:query] ? (params[:query] + "*") : "*"),\
        [Album, Photo, User]).records.to_a
      render json: @results
    end
  end
end
