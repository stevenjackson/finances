require 'require_all'
require 'fig_newton'
require_rel '.'
module GatewayFactory
  class << self

    FigNewton.yml_directory = File.join File.expand_path(File.dirname(__FILE__)), 'config', 'environments'

    def create(environment)
      FigNewton.load "#{environment}.yml"
      ds = FigNewton.default_datasource
      self.send ds, FigNewton.send(ds).to_hash
    end

    def sqlite(params)
      SqliteGateway.new params['url']
    end
  end
end
