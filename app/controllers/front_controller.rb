class FrontController < ApplicationController

  def index
    if params[:q].present?
      @documents = Document.where(:content => /#{Regexp.escape(params[:q])}/im)
    else
      @documents = Document.all.only(:title, :date)
    end
    @documents = @documents.desc(:date)
  end

  def doc
    @document = Document.find(params[:id])
    p @document.content[0...1000]
  end

end
