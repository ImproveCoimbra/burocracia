class FrontController < ApplicationController

  def index
    if params[:q].present?
      search = Document.collection.find( {'$text' => { '$search' => '"'+params[:q]+'"' }}).select( { 'date' => 1} )
      @all_documents = search.entries.map{|d| Document.new(d) }.sort_by{ |doc| doc.date }.reverse
      @documents = Document.where(:id.in => @all_documents.map(&:id)).order_by(:date => :desc).page(params[:page]).per(5)
    else
      @documents = Document.all.only(:id, :title, :date).order_by(:date => :desc)
    end
  end

end
