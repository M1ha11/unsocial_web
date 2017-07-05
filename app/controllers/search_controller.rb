class SearchController < ApplicationController
  def search
    if search_params[:q].nil?
      @result = []
    else
      @result = Elasticsearch::Model.search((search_params[:q] ? (search_params[:q] + "*") : "*"), [Album, Photo, User]).records
    end
    binding.pry
  end

    private

    def search_params
      params.require(:search).permit(:q)
    end
end
