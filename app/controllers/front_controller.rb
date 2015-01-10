class FrontController < ApplicationController
  def index
    @documents = Document.all.only(:id, :title, :date).order_by(date: :desc)
  end

  def search
    @all_documents = Document.search params[:q]
    @documents = Document.where(:id.in => @all_documents.map(&:id))
                 .order_by(date: :desc)
                 .page(params[:page]).per(5)
  end
end
