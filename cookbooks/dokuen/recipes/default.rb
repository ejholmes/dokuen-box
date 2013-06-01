directory '/data'

# Vim is essential
package 'vim'

include_recipe "ruby_build"
include_recipe "rbenv::system"
include_recipe "postgresql"
include_recipe "postgresql::server"
include_recipe "nginx"
