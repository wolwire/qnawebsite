def template(from, to, options = {})
  template_path = File.expand_path("../templates/#{from}", __FILE__)
  template = ERB.new(File.new(template_path).read).result(binding)
  upload! StringIO.new(template), to, mode: 0644 # Otherwise it's set to 0640, which is not readable by other users (https://github.com/net-ssh/net-scp/blob/master/lib/net/scp/upload.rb#L63)
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless fetch(name)
end
