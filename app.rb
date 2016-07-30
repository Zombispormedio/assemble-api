require 'rubygems'
require 'bundler'

Bundler.require
$: << File.expand_path('../', __FILE__)
$: << File.expand_path('../lib', __FILE__)

require 'sinatra/base'
require 'sinatra/reloader' if development? # sinatra-contrib
require 'sinatra/activerecord'
require 'sinatra/namespace'

require 'aws-sdk'
require 'rmagick'
require 'securerandom'
require 'pathname'

require_relative "lib/redis_wrapper"
require_relative "lib/jwt_wrapper"

require_relative "lib/s3_wrapper"
require_relative "lib/magick_wrapper"

require_relative 'lib/utils'
require_relative 'app/helpers/response_helper'
require_relative 'app/helpers/endpoint_helper'
require_relative 'app/helpers/session_helper'
require_relative 'app/helpers/selection_helper'
require_relative 'app/helpers/image_helper'


require_relative 'app/models/user'
require_relative 'app/models/friendship'
require_relative 'app/models/friendship_request'

require_relative 'app/controllers/oauth_controller'
require_relative 'app/controllers/user_controller'
require_relative 'app/controllers/friendship_controller'
require_relative 'app/controllers/profile_controller'


require_relative 'app/routes/base'
require_relative 'app/routes/authenticable'

require_relative 'app/routes/oauth'
require_relative 'app/routes/user'
require_relative 'app/routes/friendship'
require_relative 'app/routes/profile'

Aws.use_bundled_cert!


module AssembleAPI
  class App < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    include ResponseHelper

    configure :development do
      register Sinatra::Reloader
    end

    configure do
      set :database, {
          adapter: 'postgresql', encoding: 'unicode',
          database: ENV['POSTGRE_DATABASE'], pool: 2,
          host: ENV['POSTGRE_HOSTNAME'],
          username: ENV['POSTGRE_USER'], password: ENV['POSTGRE_PASS']
      }
    end


    Routes.constants.each do |e|
      use Routes.const_get(e)
    end

    not_found do
      error({msg: "Whoops! You requested a endpoint that wasn't available."})
    end

    error do
      error ({msg: "Y U NO WORK?"})
    end

  end

end

