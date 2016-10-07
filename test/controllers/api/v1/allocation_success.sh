#!/bin/env ruby

require 'awesome_print'
require_relative 'helper'

server_ip    = read_conf 'config.txt', 'SERVER_IP'
server_port  = read_conf 'config.txt', 'SERVER_PORT'
project_name = read_conf 'config.txt', 'PROJECT_NAME'
user_email   = read_conf 'config.txt', 'USER_EMAIL'


post_data = %Q|'{"user":"#{user_email}","mark":{"label":"hoge","description":"hoge desc"}}'|

cmd = <<"EOL"
  curl -v \
    -H "Accept: application/json" \
    -H "Content-type: application/json" \
    -X POST  \
    -d #{post_data} \
    http://#{server_ip}:#{server_port}/api/v1/projects/#{project_name}/numbers.json
EOL

$ret = `#{cmd}`
ap $?
ap $ret
