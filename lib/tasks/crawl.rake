# -*- encoding : utf-8 -*-

# Download all actas
task :actas => :environment do
  require 'open-uri'

  start_url = 'http://www.cm-coimbra.pt/index.php?option=com_docman&task=cat_view&gid=128&Itemid=381'
  doc_urls = []

  open(start_url) do |f|

    year_urls = []
    start_doc = Nokogiri::HTML(f.read)
    start_doc.xpath('//div[@id=\'dm_cats\']//a[@class=\'dm_name\']').each do |link|
      year_urls << link['href']
      year_urls << link['href']+'&limit=40&limitstart=40' # second page
    end

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

  puts "Got #{doc_urls.size} docs!"

  #doc_urls = ['http://www.cm-coimbra.pt/index.php?option=com_docman&task=doc_download&gid=6442&Itemid=381']

  def get_page_content page
    content = page.text
    map = {}
    map['ˆ'] = 'Ã'
    map['`'] = 'Á'
    map['´'] = 'Â'
    map['Ø'] = 'é'
    map['˝'] = 'Í'
    map['˙'] = 'Ç'
    map['ª'] = 'ã'
    map['Œ'] = 'ê'
    map['Æ'] = 'á'
    map['œ'] = 'ú'
    map['ı'] = 'õ'
    map['”'] = '«««' # º
    map['“'] = '»»»' # ª
    #map['º'] = '"'
    #map['ª'] = '"'
    map['«««'] = 'º'
    map['»»»'] = 'ª'
    map.each { |a,b| content.gsub!(a,b) }
    #content.gsub!(/ª([\w\s]{3,1000}?)º/, '"\1"')
    lines = content.split(/\n/)
    content = ""
    lines.each do |line|
      line.strip!
      next if line =~ /^Ac?ta\s+nº/
      content << line + "\n"
    end
    content.gsub!(/(\n){3,}/, '<br/><br/>')
    content.gsub!(/(\n)+/, '<br/>')
    content
  end

  doc_urls.each do |doc_url|
    reader = PDF::Reader.new(open(doc_url))
    document = Document.new
    document.title = reader.info[:Title]
    document.source_url = doc_url
    document.content = ""
    reader.pages.each do |page|
      content = get_page_content(page)
      unless document.date
        matches = /data:?\s*(\d{2})\/(\d{2})\/(\d{2,4})/i.match(content)
        document.date = Date.new(matches[3].to_i, matches[2].to_i, matches[1].to_i) if matches
      end
      document.content << content
    end
    document.save
    puts '.'
  end

end

# Download all actas
task :actas_miner => :environment do
  require 'open-uri'

  #Document.all.destroy

  start_url = 'http://www.cm-coimbra.pt/index.php?option=com_docman&task=cat_view&gid=128&Itemid=381'
  doc_urls = []

  open(start_url) do |f|

    year_urls = []
    start_doc = Nokogiri::HTML(f.read)
    start_doc.xpath('//div[@id=\'dm_cats\']//a[@class=\'dm_name\']').each do |link|
      year_urls << link['href']
      year_urls << link['href']+'&limit=40&limitstart=40' # second page
    end

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

  puts "Got #{doc_urls.size} docs!"

  #doc_urls = ['http://www.cm-coimbra.pt/index.php?option=com_docman&task=doc_download&gid=6442&Itemid=381']
  doc_urls.each do |doc_url|
    if Document.where(:source_url => doc_url).count == 0
      open("temp.pdf", "wb") do |file|
        file.write(open(doc_url).read)
      end

      document = Document.new
      document.source_url = doc_url
      document.content = `cmd.exe /c pdf2txt.py -M 100 -W 100 temp.pdf`

      # Remove spaces before some chars
      %w{ç í â Ó ó ô}.each do |letter|
        document.content.gsub!(/\s#{letter}/, letter)
      end

      matches = /data:?\s*(\d{2})\/(\d{2})\/(\d{2,4})/i.match(document.content)
      document.date = Date.new(matches[3].to_i, matches[2].to_i, matches[1].to_i) if matches

      document.save
      puts '.'
    end
  end

end
