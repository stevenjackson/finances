notification :tmux,
  :display_message => false,
  :timeout => 5, # in seconds
  :default_message_format => '%s >> %s',
  :line_separator => ' > ', # since we are single line we need a separator
  :color_location => 'status-left-bg' # to customize which tmux element will change color

group :tests, :halt_on_fail => true  do
  guard :rspec, :cmd => 'rspec --color --format Fuubar', :all_on_start => true do
    watch(%r{^spec/.+_spec\.rb$})
    watch(%r{^lib/(.+)\.rb$})     { "spec" } 
    watch('spec/spec_helper.rb')  { "spec" }
  end

  guard 'cucumber', :cli => '--profile guard', :notification => true, :all_after_pass => false do
    watch(%r{^features/.+$})                  { "features" }
    watch(%r{^lib/.+\.rb$})                   { "features" }
    watch(%r{^cucumber.yml$})                 { "features" }
    watch(%r{^delivery/rails_app/.+rb$})      { "features" }
    watch(%r{^gateway/.+rb$})                 { "features" }
  end
end

