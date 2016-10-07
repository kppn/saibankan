def read_conf config, target
  ret = ''
  File.open(config) do |f|
    ret = f.readlines.grep(/#{target}/)[0].split[1]
  end
  ret
end
