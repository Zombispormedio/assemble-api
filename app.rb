require 'rubygems'
require 'bundler'

Bundler.require
$: << File.expand_path('../', __FILE__)
$: << File.expand_path('../lib', __FILE__)

require 'sinatra/base'
require 'sinatra/reloader' if development? # sinatra-contrib
require 'sinatra/activerecord'
require 'sinatra/namespace'


require_relative 'app/routes/base'

require_relative 'app/routes/oauth'
require_relative 'app/routes/user'

module AssembleAPI
    class App < Sinatra::Base
        register Sinatra::ActiveRecordExtension
        register Sinatra::Namespace

        configure :development do
            register Sinatra::Reloader
        end

      configure do
          set :database, {
              adapter: 'postgresql',  encoding: 'unicode',
              hostname: ENV['POSTGRE_HOSTNAME'], database: ENV['POSTGRE_DATABASE'], pool: 2,
              username: ENV['POSTGRE_USER'], password: ENV['POSTGRE_PASS']
          }
      end


          Routes.constants.each do |e|
            use Routes.const_get(e)
          end


    end

end

