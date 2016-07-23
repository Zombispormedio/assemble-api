module Endpoint
  def self.included(base)
    base.class_eval do
      set(:prefix) { "/" << name[/[^:]+$/].downcase }
    end
  end
end
class Base < Sinatra::Application

  configure do
    set :root, File.expand_path('../../../', __FILE__)

    disable :method_override
    disable :protection
    disable :static
  end

  before do
    $host_port = request.host_with_port
  end
end