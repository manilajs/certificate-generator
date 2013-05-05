#!/usr/bin/env ruby

def slugify(str, salt)
  require 'digest'
  Digest::SHA1.hexdigest(salt + str)
end

template = File.read('template/index.html')
output = []
salt = "manila-js-003-"

STDIN.read.split("\n").each do |line|
  name, email = line.split(",")

  slug = slugify(email, salt)
  html = template.gsub('{{ name }}', name)
  out  = "pdf/#{slug}.pdf"
  tmp  = "template/_tmp.html"
  File.open(tmp, 'w') { |f| f.write html }

  # puts "==> #{out} (#{name})"
  output << [name, email, slug].join(",")
  system "xhtml2pdf template/_tmp.html #{out} 1>&2"
  File.unlink tmp
end


puts output.join("\n")
