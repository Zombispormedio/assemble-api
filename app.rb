require 'rubygems'
require 'bundler'

Bundler.require
$: << File.expand_path('../', __FILE__)
$: << File.expand_path('../lib', __FILE__)

require 'sinatra/base'
require 'sinatra/reloader' if development? # sinatra-contrib
require 'sinatra/activerecord'

module AssembleAPI
    class App < Sinatra::Base
        register Sinatra::ActiveRecordExtension

        configure :development do
            register Sinatra::Reloader
        end

      
    end

end