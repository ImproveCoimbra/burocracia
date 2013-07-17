class FrontController < ApplicationController

  def index
    if params[:q].present?
      search = Document.limit(1000).text_search('"'+params[:q]+'"')
      @stats = search.stats
      @documents = search.entries.sort_by! { |doc| doc.date }
    else
      @documents = Document.all.only(:title, :date).order_by(:date => :desc)
    end
  end

  def doc
    @document = Document.find(params[:id])
  end

end
