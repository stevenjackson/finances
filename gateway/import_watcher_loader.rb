require 'gateway_factory'
require 'fig_newton'
include Finances
include EnvironmentLoader

module ImportWatcherLoader
  def start_watcher!(env)
    gateway = GatewayFactory.create env
    import_path = data_path FigNewton.import_folder

    watcher = ImportWatcher.new(gateway)
    watcher.run import_path: import_path
    watcher.start!
  end
end
