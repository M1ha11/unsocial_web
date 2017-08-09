class SearchController < ApplicationController
  def search
    if params[:query].empty?
      @results = []
    else
      @results = Elasticsearch::Model.search((params[:query] ? (params[:query] + "*") : "*"),\
        [Album, Photo, User]).records(includes: { Album: [:user], Photo: [:album] }).to_a
    end
    render json: @results
  end

  def tag_search
    if params[:q].empty?
      @tags = []
    else
      @tags = Tag.search(params[:q]).records.all.first(10)
    end
    render json: @tags
  end
end

