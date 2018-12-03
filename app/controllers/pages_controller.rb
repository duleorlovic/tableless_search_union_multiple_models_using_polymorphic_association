class PagesController < ApplicationController
  def home
    @search = Search.new
  end

  def search
    @search = Search.new _search_params
    @search.perform
  end

  def _search_params
    params.require(:search).permit(
      :s
    )
  end
end
