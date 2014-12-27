# -*- encoding : utf-8 -*-

desc "Check for new pdf documents from the council website, download, convert to txt and import to the database"
task :import_new_documents => :environment do
  require 'open-uri'

  puts "Looking for new documents..."

  # Crawl the council website for all documents, from a start URL

  start_url = 'http://www.cm-coimbra.pt/index.php?option=com_docman&task=cat_view&gid=128&Itemid=381'
  doc_urls = []

  open(start_url) do |f|

    # Find all year folders
    year_urls = []
    start_doc = Nokogiri::HTML(f.read)
    start_doc.xpath('//div[@id=\'dm_cats\']//a[@class=\'dm_name\']').each do |link|
      year_urls << link['href']
      year_urls << link['href']+'&limit=40&limitstart=40' # second page
    end

    # Get the documents URLs from inside the year folders
    year_urls.uniq!
    year_urls.each do |year_url|
      open(year_url) do |f|
        start_doc = Nokogiri::HTML(f.read)
        start_doc.xpath('//div[@id=\'dm_docs\']//a[@class=\'dm_name\']').each do |link|
          doc_urls << link['href']
          print '.'
        end
      end
    end

  end

  doc_urls.uniq!

  puts
  puts "Found a total of #{doc_urls.size} documents."

  # Import the new documents

  doc_urls.each do |doc_url|
    if Document.where(:source_url => doc_url).count == 0
      puts "Importing: " + doc_url

      # Download document
      open("temp.pdf", "wb") do |file|
        file.write(open(doc_url).read)
      end

      document = Document.new
      document.source_url = doc_url
      # Convert document's pdf file to txt and save its content
      document.content = `pdf2txt.py -M 100 -W 100 temp.pdf`

      # Remove spaces before some chars
      %w{ç í â Ó ó ô}.each do |letter|
        document.content.gsub!(/\s#{letter}/, letter)
      end

      # Figure out the document date
      matches = /data:?\s*(\d{2})\/(\d{2})\/(\d{2,4})/i.match(document.content)
      document.date = Date.new(matches[3].to_i, matches[2].to_i, matches[1].to_i) if matches

      document.save

      File.delete('temp.pdf')
    end
  end

  puts "Done."

end

desc "Try to guess a document date from its content (if it doesn't have a date yet)"
task :fetch_dates => :environment do

  Document.all.each do |document|
    unless document.date
      matches = /data:?\s*(\d{1,2})\/(\d{1,2})\/(\d{2,4})/i.match(document.content)
      if matches
        year = matches[3].to_i
        year += 1900 if year < 100
        document.date = Date.new(year, matches[2].to_i, matches[1].to_i)
        document.save
        next
      end
      matches = /acta\s+nº\.?\s*\d+\s+de\s+(\d{1,2})\/(\d{1,2})\/(\d{2,4})/i.match(document.content)
      if matches
        year = matches[3].to_i
        year += 1900 if year < 100
        document.date = Date.new(year, matches[2].to_i, matches[1].to_i)
        document.save
        next
      end
    end
  end

end
