module FrontHelper
  def organize(documents)
    docs = {}
    documents.each do |document|
      next unless document.date
      year = document.date.year
      month = document.date.month
      docs[year] ||= {}
      docs[year][month] ||= []
      docs[year][month] << document
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
