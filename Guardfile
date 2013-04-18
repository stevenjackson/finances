# A sample Guardfile
# More info at https://github.com/guard/guard#readme


guard 'rspec', :cli => '--color --format Fuubar' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { "spec" } 
  watch('spec/spec_helper.rb')  { "spec" }
end
guard 'spork', :rspec => false, :cucumber_env => { 'RAILS_ENV' => 'test' } do
end

guard 'cucumber', :cli => '--drb --format progress --no-profile --tag @wip', :notification => true, :all_after_pass => false do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$})          { "features" }
  watch(%r{^lib/.+\.rb$})                   { "features" }
  watch(%r{^cucumber.yml$})                 { "features" }
end
