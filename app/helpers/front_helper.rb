module FrontHelper

  def organize(documents)
    docs = {}
    documents.each do |document|
      if document.date
        docs[document.date.year] ||= {}
        docs[document.date.year][document.date.month] ||= []
        docs[document.date.year][document.date.month] << document
      end
    end
    docs
  end

end
