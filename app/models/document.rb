class Document
  include Mongoid::Document
  include Mongoid::Timestamps
  #include Mongoid::MultiParameterAttributes

  field :title
  field :content
  field :tags, :type => Array
  field :date, :type => Date
  field :source_url

  index({:date => -1}, {:background => true})
  index({:content => 'text'}, {:default_language => 'portuguese', :background => true})

  def content_html
  	content.gsub(/(\s*\n\s*){2,}/, '<br/><br/>').gsub(/\s*\n\s*/, '<br/>').html_safe
  end

end
