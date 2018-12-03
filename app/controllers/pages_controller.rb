class PagesController < ApplicationController

  SORT_BY_OPTIONS = {
    name_asc: 'Name Asc',
    name_desc: 'Name Desc',
    created_at_asc: 'Created Asc',
    created_at_desc: 'Created Desc',
  }.freeze

  def home
  end

  def search
    @search_result = SearchResult.search(params[:s])
    @search_result = case params[:sort_by]
    when 'name_asc'
      @search_result.order('name ASC')
    when 'name_desc'
      @search_result.order('name DESC')
    when 'created_at_asc'
      @search_result.order('created_at ASC')
    when 'created_at_desc'
      @search_result.order('created_at DESC')
    else
      @search_result
    end
  end
end
