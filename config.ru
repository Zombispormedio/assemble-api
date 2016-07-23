require './app'

configure { set :server, :puma }

run AssembleAPI::App