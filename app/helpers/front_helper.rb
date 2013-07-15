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

  def count_by_year(documents)
    counts = {}
    documents[-1].date.year.upto(documents[0].date.year) do |year|
      counts[year] = 0
    end
    documents.each do |document|
      counts[document.date.year] += 1 if document.date
    end
    counts
  end

end
