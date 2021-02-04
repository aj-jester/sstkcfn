$:.unshift File.join File.dirname(__FILE__), 'sstkcfn'

%w[
aws
cli
config
error
helper
opts
template
tasks/create_stack
tasks/delete_stack
tasks/gen_fragment
tasks/gen_template
tasks/stack_events
tasks/update_stack
].each { |m| require m }

