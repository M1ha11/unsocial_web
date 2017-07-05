class SearchController < ApplicationController
  def search
    if params[:search][:q].nil?
      @users = []
      @albums = []
      @tags_search = []
    else
      @users = User.search(params[:search][:q]).records.all
      @albums = Album.search(params[:search][:q]).records.all
      @tags_search = Tag.search(params[:search][:q]).records.all
    end
  end
end
