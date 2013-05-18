require 'fig_newton'
require 'require_all'
require_rel '*.rb'
module GatewayFactory
  class << self
    include EnvironmentLoader

    def create(environment)
      load_env environment
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

  end
end
