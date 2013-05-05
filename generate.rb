#!/usr/bin/env ruby

def slugify(str)
  str.scan(/[A-Za-z]+/).join("-").downcase
end

template = File.read('template/index.html')

STDIN.read.split("\n").each do |line|
  name, email = line.split(",")

  slug = slugify(email)
  html = template.gsub('{{ name }}', name)
  out  = "pdf/#{slug}.pdf"
  tmp  = "template/_tmp.html"
  File.open(tmp, 'w') { |f| f.write html }

  # puts "==> #{out} (#{name})"
  system "xhtml2pdf template/_tmp.html #{out}"
  File.unlink tmp
end

