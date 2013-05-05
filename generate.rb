#!/usr/bin/env ruby

def slugify(str)
  require 'digest'
  Digest::SHA1.hexdigest(str)
end

template = File.read('template/index.html')
output = []

STDIN.read.split("\n").each do |line|
  name, email = line.split(",")

  slug = slugify(email)
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
