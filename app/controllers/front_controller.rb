class FrontController < ApplicationController

  def index
    if params[:q].present?
      search = Document.limit(1000).text_search('"'+params[:q]+'"').project({:_id => 1, :date => 1})
      @stats = search.stats
      @all_documents = search.entries.sort_by!{ |doc| doc.date }.reverse
      @documents = Document.where(:_id.in => @all_documents.map(&:_id)).order_by(:date => :desc).page(params[:page]).per(5)
    else
      @documents = Document.all.only(:title, :date).order_by(:date => :desc)
    end
  end

  def doc
    @document = Document.find(params[:id])
  end

end
