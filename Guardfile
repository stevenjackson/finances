notification :tmux,
  :display_message => true,
  :timeout => 5, # in seconds
  :default_message_format => '%s >> %s',
  :line_separator => ' > ', # since we are single line we need a separator
  :color_location => 'status-left-bg' # to customize which tmux element will change color

guard 'spork', :rspec => false, :cucumber_env => { 'RAILS_ENV' => 'test' } do 
end

group :tests, :halt_on_fail => true  do
  guard 'rspec', :cli => '--color --format Fuubar' do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { "spec" } 
    watch('spec/spec_helper.rb')  { "spec" }
  end

  guard 'cucumber', :cli => '--drb --format progress --no-profile --tag @wip', :notification => true, :all_after_pass => false do
    watch(%r{^features/.+$})                  { "features" }
    watch(%r{^lib/.+\.rb$})                   { "features" }
    watch(%r{^cucumber.yml$})                 { "features" }
    watch(%r{^delivery/rails_app/.+rb$})    { "features" }
  end
end
