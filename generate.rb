#!/usr/bin/env ruby

def slugify(str, salt)
  require 'digest'
  Digest::SHA1.hexdigest(salt + str)
end

template = File.read('template/index.html')
output = []
salt = "manila-js-003-"
passsalt = "mjs003" # change me

STDIN.read.split("\n").each do |line|
  name, email = line.split(",")

  slug = slugify(email, salt)
  pass = slugify(slug, salt)[0..10]
  html = template.gsub('{{ name }}', name)
  out  = "#{slug}.pdf"
  tmp  = "template/_tmp.html"
  File.open(tmp, 'w') { |f| f.write html }

  # puts "==> #{out} (#{name})"
  output << [name, email, out, pass].join(",")
  system "xhtml2pdf template/_tmp.html pdf/_tmp.pdf 1>&2"
  system "pdftk pdf/_tmp.pdf output pdf/#{out} owner_pw #{pass}_ user_pw #{pass} allow printing"
  File.unlink tmp
end


puts output.join("\n")
