require 'configatron'
require 'cachetastic'
require 'drb/drb'
require 'drb/acl'
require 'rinda/ring'
require 'addressable/uri'

base = File.join(File.dirname(__FILE__), 'distribunaut')

configatron.distribunaut.set_default(:share_routes, false)
configatron.distribunaut.set_default(:share_objects, false)
configatron.distribunaut.set_default(:share_views, false)
configatron.distribunaut.set_default(:app_name, nil)
configatron.distribunaut.set_default(:site_domain, nil)
configatron.distribunaut.set_default(:timeout, 0)
configatron.distribunaut.set_default(:enable_view_cache, false)

# load *.rb files
Dir.glob(File.join(base, "**", "*.rb")).each do |f|
  load(f)
end

Distribunaut::Distributed::View.register

