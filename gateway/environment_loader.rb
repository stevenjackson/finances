require 'fig_newton'
module EnvironmentLoader
  def load_env(environment)
    FigNewton.yml_directory = find_path '..', 'config', 'environments'
    FigNewton.load "#{environment}.yml"
  end

  def find_path(*args)
    File.join(File.expand_path(File.dirname(__FILE__)), *args)
  end
end
