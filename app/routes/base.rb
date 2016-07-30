
class Base < Sinatra::Application
  include EndpointHelper
  include ResponseHelper
  register Sinatra::Namespace

  configure do
    set :root, File.expand_path('../../../', __FILE__)

    disable :method_override
    disable :protection
    disable :static
  end

  before do
    $host_port = request.host_with_port
    content_type :json
  end
end