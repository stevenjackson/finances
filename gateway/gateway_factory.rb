require 'require_all'
require 'fig_newton'
require_rel '.'
module GatewayFactory
  class << self
    def create(environment)
      FigNewton.yml_directory = find_path '..', 'config', 'environments'
      FigNewton.load "#{environment}.yml"
      ds = FigNewton.default_datasource
      self.send ds, FigNewton.send(ds).to_hash
    end

    def sqlite(params)
      url = params['url']
      unless url
        url = "sqlite://#{find_path 'data', params['file']}"
      end
      SqliteGateway.new url 
    end

    def find_path(*args)
      File.join(File.expand_path(File.dirname(__FILE__)), *args)
    end
  end
end
