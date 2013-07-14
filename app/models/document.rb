class Document
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title
  field :content
  field :tags, :type => Array
  field :date, :type => Date
  field :source_url

  index :date, :background => true

  def content_html
  	content.gsub!(/(\s*\n\s*){2,}/, '<br/><br/>').gsub!(/\s*\n\s*/, '<br/>').html_safe
  end

end
