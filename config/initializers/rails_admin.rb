RailsAdmin.config do |config|

  config.authorize_with do
    authenticate_or_request_with_http_basic('Burocracia Admin') do |username, password|
      username == 'improve' && password == (ENV['ADMIN_PASSWORD'] || 'improve')
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
  end

  config.model 'Document' do
    configure :content, :text
    list do
      field :date
      field :title
      field :tags
      field :created_at
      field :updated_at
    end
  end
end
